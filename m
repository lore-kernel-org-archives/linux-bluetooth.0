Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1439479210-30881-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZJwk0FsiUtyN8Sm6bvT1iL_mY88-eKi6Vp=MTNRVh0hTQ@mail.gmail.com>
 <CABBYNZKZTzoiX7wcgJJnzVOZFUH8AHL9qodd4U=svzfa9Mo2Yg@mail.gmail.com>
In-reply-to: <CABBYNZKZTzoiX7wcgJJnzVOZFUH8AHL9qodd4U=svzfa9Mo2Yg@mail.gmail.com>
Subject: RE: [PATCH v1] audio/avrcp: Add Set Addressed Player support
Date: Fri, 14 Aug 2015 18:21:19 +0530
Message-id: <02d201d0d68f$ff7e0260$fe7a0720$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, August 14, 2015 6:15 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH v1] audio/avrcp: Add Set Addressed Player support
> 
> Hi Bharat,
> 
> On Fri, Aug 14, 2015 at 3:30 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Bharat,
> >
> > On Thu, Aug 13, 2015 at 6:20 PM, Bharat Panda
> <bharat.panda@samsung.com> wrote:
> >> Support added to handle Set Addressed Player PDU in TG role.
> >> Send EVENT_ADDRESSED_PLAYER_CHANGED on SetAddressedPlayer
> SUCCESS and
> >> follow procedure to reject all player specific events currently
> >> registered with the player.
> >>
> >>       Channel: 64 len 15 [PSM 23 mode 0] {chan 0}
> >>       AVCTP Control: Command: type 0x00 label 0 PID 0x110e
> >>         AV/C: Control: address 0x48 opcode 0x00
> >>           Subunit: Panel
> >>           Opcode: Vendor Dependent
> >>           Company ID: 0x001958
> >>           AVRCP: SetAddressedPlayer pt Single len 0x0002
> >>             PlayerID: 0x0000 (0)
> >>
> >>       Channel: 64 len 15 [PSM 23 mode 0] {chan 0}
> >>       AVCTP Control: Response: type 0x00 label 0 PID 0x110e
> >>         AV/C: Accepted: address 0x48 opcode 0x00
> >>           Subunit: Panel
> >>           Opcode: Vendor Dependent
> >>           Company ID: 0x001958
> >>           AVRCP: SetAddressedPlayer pt Single len 0x0002
> >>             Status: 0x04 (Success)
> >>
> >>       Channel: 64 len 18 [PSM 23 mode 0] {chan 0}
> >>       AVCTP Control: Response: type 0x00 label 0 PID 0x110e
> >>         AV/C: Changed: address 0x48 opcode 0x00
> >>           Subunit: Panel
> >>           Opcode: Vendor Dependent
> >>           Company ID: 0x001958
> >>           AVRCP: RegisterNotification pt Single len 0x0005
> >>             EventID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
> >>             PlayerID: 0x0000 (0)
> >>             UIDCounter: 0x0000 (0)
> >> ---
> >>  profiles/audio/avrcp.c | 131
> >> +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 131 insertions(+)
> >>
> >> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c index
> >> d66f670..61d91ea 100644
> >> --- a/profiles/audio/avrcp.c
> >> +++ b/profiles/audio/avrcp.c
> >> @@ -103,6 +103,7 @@
> >>  #define AVRCP_REQUEST_CONTINUING       0x40
> >>  #define AVRCP_ABORT_CONTINUING         0x41
> >>  #define AVRCP_SET_ABSOLUTE_VOLUME      0x50
> >> +#define AVRCP_SET_ADDRESSED_PLAYER     0x60
> >>  #define AVRCP_SET_BROWSED_PLAYER       0x70
> >>  #define AVRCP_GET_FOLDER_ITEMS         0x71
> >>  #define AVRCP_CHANGE_PATH              0x72
> >> @@ -204,8 +205,10 @@ struct avrcp_player {
> >>         uint64_t uid;
> >>         uint16_t uid_counter;
> >>         bool browsed;
> >> +       bool addressed;
> >>         uint8_t *features;
> >>         char *path;
> >> +       guint notify_id;
> >>
> >>         struct pending_list_items *p;
> >>         char *change_path;
> >> @@ -631,6 +634,7 @@ void avrcp_player_event(struct avrcp_player
> *player, uint8_t id,
> >>         GSList *l;
> >>         int attr;
> >>         int val;
> >> +       bool player_changed = false;
> >>
> >>         if (player->sessions == NULL)
> >>                 return;
> >> @@ -674,6 +678,12 @@ void avrcp_player_event(struct avrcp_player
> *player, uint8_t id,
> >>                 pdu->params[size++] = attr;
> >>                 pdu->params[size++] = val;
> >>                 break;
> >> +       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> >> +               size = 5;
> >> +               memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
> >> +               memcpy(&pdu->params[3], &player->uid_counter,
> sizeof(uint16_t));
> >> +               player_changed = true;
> >> +               break;
> >>         case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> >>                 size = 1;
> >>                 break;
> >> @@ -695,6 +705,7 @@ void avrcp_player_event(struct avrcp_player
> *player, uint8_t id,
> >>                                         session->transaction_events[id],
> >>                                         AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
> >>                                         buf, size +
> >> AVRCP_HEADER_LENGTH);
> >> +
> >>                 if (err < 0)
> >>                         continue;
> >>
> >> @@ -702,6 +713,52 @@ void avrcp_player_event(struct avrcp_player
> *player, uint8_t id,
> >>                 session->registered_events ^= 1 << id;
> >>         }
> >>
> >> +       if (player_changed) {
> >> +               uint8_t player_events[6] = {
> >> +                                       AVRCP_EVENT_STATUS_CHANGED,
> >> +                                       AVRCP_EVENT_TRACK_CHANGED,
> >> +                                       AVRCP_EVENT_TRACK_REACHED_START,
> >> +                                       AVRCP_EVENT_TRACK_REACHED_END,
> >> +                                       AVRCP_EVENT_SETTINGS_CHANGED,
> >> +                                       AVRCP_EVENT_PLAYBACK_POS_CHANGED
> >> +                                       };
> >> +
> >> +               for (l = player->sessions; l; l = l->next) {
> >> +                       struct avrcp *session = l->data;
> >> +                       int err;
> >> +                       int i;
> >> +
> >> +                       for (i = 0; i < 6; i++) {
> >
> > Check with i < sizeof(player_events) so in case we need to add some
> > new event we don't need to always keep changing this.
> >
> >> +                               if (!(session->registered_events &
> >> +                                               (1 << player_events[i])))
> >> +                                       continue;
> >> +
> >> +                               if (session->registered_events &
> >> +                                               (1 << player_events[i])) {
> >> +                                       session->registered_events &=
> >> +                                               ~(1 << player_events[i]);
> >> +                               /*
> >> +                                * TG shall complete all player specific
> >> +                                * notifications with AV/C C-Type REJECTED
> >> +                                * with error code as Addressed Player Changed.
> >> +                                */
> >> +
> >> +                               pdu->params[0] =
> >> +                                       AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED;
> >> +                               pdu->params_len = htons(1);
> >> +                               err = avctp_send_vendordep(session->conn,
> >> +                                       session->transaction_events[player_events[i]],
> >> +                                       AVC_CTYPE_REJECTED, AVC_SUBUNIT_PANEL,
> >> +                                       buf, 1 + AVRCP_HEADER_LENGTH);
> >> +                               }
> >> +                       }
> >> +
> >> +                       if (err < 0)
> >> +                               continue;
> >> +
> >> +               }
> >> +       }
> >> +
> >>         return;
> >>  }
> >>
> >> @@ -1494,6 +1551,11 @@ static uint8_t
> avrcp_handle_register_notification(struct avrcp *session,
> >>                 }
> >>
> >>                 break;
> >> +       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> >> +               len = 5;
> >> +               memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
> >> +               memcpy(&pdu->params[3], &player->uid_counter,
> sizeof(uint16_t));
> >> +               break;
> >>         case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> >>                 len = 1;
> >>                 break;
> >> @@ -1617,6 +1679,72 @@ err:
> >>         return AVC_CTYPE_REJECTED;
> >>  }
> >>
> >> +static struct avrcp_player *find_tg_player(struct avrcp *session,
> >> +uint16_t id) {
> >> +       struct avrcp_server *server = session->server;
> >> +       GSList *l;
> >> +
> >> +       for (l = server->players; l; l = l->next) {
> >> +               struct avrcp_player *player = l->data;
> >> +
> >> +               if (player->id == id)
> >> +                       return player;
> >> +       }
> >> +
> >> +       return NULL;
> >> +}
> >> +
> >> +static gboolean notify_addressed_player_changed(gpointer user_data)
> >> +{
> >> +       struct avrcp_player *player = user_data;
> >> +
> >> +       avrcp_player_event(player,
> >> +                               AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
> >> +       g_source_remove(player->notify_id);
> >
> > Removing the source wouldn't be necessary if you return FALSE or
> > G_SOURCE_REMOVE if we want to more gnomish, furthermore notify_id
> > shall be set to 0 either way and the call to g_source_remove shall be
> > move to where the player freed so we stop the callback to be called if
> > the player is unregistered.
> 
> Actually don't use G_SOURCE_REMOVE since it was introduced in 2.32 and
> we depend on 2.28 or later.
Ok, so here we should return only FALSE and upon unregister_player, will remove source using g_source_remove(player->notify_id) will be enough then.
> 
> >
> >> +
> >> +       return TRUE;
> >> +}
> >> +
> >> +static uint8_t avrcp_handle_set_addressed_player(struct avrcp
> *session,
> >> +                                               struct avrcp_header *pdu,
> >> +                                               uint8_t transaction)
> >> +{
> >> +       struct avrcp_player *player;
> >> +       uint16_t len = ntohs(pdu->params_len);
> >> +       uint16_t player_id = 0;
> >> +       uint8_t status;
> >> +
> >> +       if (len < 1) {
> >> +               status = AVRCP_STATUS_INVALID_PARAM;
> >> +               goto err;
> >> +       }
> >> +
> >> +       player_id = bt_get_be16(&pdu->params[0]);
> >> +       player = find_tg_player(session, player_id);
> >> +       pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
> >> +
> >> +       if (player) {
> >> +               player->addressed = true;
> >> +               status = AVRCP_STATUS_SUCCESS;
> >> +               pdu->params_len = htons(len);
> >> +               pdu->params[0] = status;
> >> +       } else {
> >> +               status = AVRCP_STATUS_INVALID_PLAYER_ID;
> >> +               goto err;
> >> +       }
> >> +
> >> +       player->notify_id =
> >> +
> g_idle_add((GSourceFunc)notify_addressed_player_changed,
> >> +                       player);
> >> +
> >> +       return AVC_CTYPE_ACCEPTED;
> >> +
> >> +err:
> >> +       pdu->params_len = htons(sizeof(status));
> >> +       pdu->params[0] = status;
> >> +       return AVC_CTYPE_REJECTED;
> >> +}
> >> +
> >>  static const struct control_pdu_handler control_handlers[] = {
> >>                 { AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
> >>                                         avrcp_handle_get_capabilities
> >> }, @@ -1648,6 +1776,8 @@ static const struct control_pdu_handler
> control_handlers[] = {
> >>                                         avrcp_handle_request_continuing },
> >>                 { AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
> >>                                         avrcp_handle_abort_continuing
> >> },
> >> +               { AVRCP_SET_ADDRESSED_PLAYER, AVC_CTYPE_CONTROL,
> >> +
> >> + avrcp_handle_set_addressed_player },
> >>                 { },
> >>  };
> >>
> >> @@ -3521,6 +3651,7 @@ static void target_init(struct avrcp *session)
> >>                 return;
> >>
> >>         session->supported_events |=
> >> +                               (1 <<
> >> + AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> >>                                 (1 <<
> >> AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> >>
> >>         /* Only check capabilities if controller is not supported */
> >> --
> >> 1.9.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-bluetooth" in the body of a message to
> >> majordomo@vger.kernel.org More majordomo info at
> >> http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
> 
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Bharat

