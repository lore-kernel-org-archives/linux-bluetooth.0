Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140226075632.GA29630@aemeltch-MOBL1>
References: <1393336605-2467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1393336605-2467-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CABBYNZJGQJ9e7+0M_-kQGn=G3648ZRNuwULg+rKQ+tZXEehDkA@mail.gmail.com>
	<20140226075632.GA29630@aemeltch-MOBL1>
Date: Wed, 26 Feb 2014 10:16:15 +0200
Message-ID: <CABBYNZJFHyX0FKhEe0mYtUUodPP-TYyP98yyV=L5Gx6OUcO8hw@mail.gmail.com>
Subject: Re: [PATCH 2/3] android/avrcp: Add control handlers to avrcp-lib
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 26, 2014 at 9:56 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Feb 25, 2014 at 04:19:53PM +0200, Luiz Augusto von Dentz wrote:
>> Hi Andrei,
>>
>> On Tue, Feb 25, 2014 at 3:56 PM, Andrei Emeltchenko
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > ---
>> >  android/avrcp-lib.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  android/avrcp-lib.h | 12 +++++++++++
>> >  2 files changed, 72 insertions(+)
>> >
>> > diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
>> > index 136801e..95e10f2 100644
>> > --- a/android/avrcp-lib.c
>> > +++ b/android/avrcp-lib.c
>> > @@ -56,6 +56,15 @@
>> >  #define AVRCP_PACKET_TYPE_CONTINUING   0x02
>> >  #define AVRCP_PACKET_TYPE_END          0x03
>> >
>> > +/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
>> > +#define CAP_COMPANY_ID         0x02
>> > +#define CAP_EVENTS_SUPPORTED   0x03
>> > +
>> > +/* Company IDs supported by this device */
>> > +static uint32_t company_ids[] = {
>> > +       IEEEID_BTSIG,
>> > +};
>> > +
>> >  #if __BYTE_ORDER == __LITTLE_ENDIAN
>> >
>> >  struct avrcp_header {
>> > @@ -108,6 +117,8 @@ struct avrcp {
>> >         const struct avrcp_passthrough_handler *passthrough_handlers;
>> >         void *passthrough_data;
>> >         unsigned int passthrough_id;
>> > +
>> > +       uint16_t supported_events;
>> >  };
>> >
>> >  void avrcp_shutdown(struct avrcp *session)
>> > @@ -220,6 +231,53 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
>> >         cid[2] = cid_in;
>> >  }
>> >
>> > +static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
>> > +                               uint8_t transaction, uint16_t *params_len,
>> > +                               uint8_t *params, void *user_data)
>> > +{
>> > +       unsigned int i;
>> > +
>> > +       DBG("id %d params_len %d", params[0], *params_len);
>> > +
>> > +       if (*params_len != 1)
>> > +               goto fail;
>> > +
>> > +       switch (params[0]) {
>> > +       case CAP_COMPANY_ID:
>> > +               for (i = 0; i < G_N_ELEMENTS(company_ids); i++)
>> > +                       set_company_id(&params[2 + i * 3], company_ids[i]);
>> > +
>> > +               *params_len = 2 + (3 * G_N_ELEMENTS(company_ids));
>> > +               params[1] = G_N_ELEMENTS(company_ids);
>> > +
>> > +               return AVC_CTYPE_STABLE;
>> > +       case CAP_EVENTS_SUPPORTED:
>> > +               params[1] = 0;
>> > +               for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
>> > +                       if (session->supported_events & (1 << i)) {
>> > +                               params[1]++;
>> > +                               params[params[1] + 1] = i;
>> > +                       }
>> > +               }
>> > +
>> > +               *params_len = 2 + params[1];
>> > +
>> > +               return AVC_CTYPE_STABLE;
>> > +       }
>> > +
>> > +fail:
>> > +       *params_len = htons(1);
>> > +       params[0] = AVRCP_STATUS_INVALID_PARAM;
>> > +
>> > +       return AVC_CTYPE_REJECTED;
>> > +}
>> > +
>> > +static const struct avrcp_control_handler control_handlers[] = {
>> > +               { AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
>> > +                                       avrcp_handle_get_capabilities },
>> > +               { },
>> > +};
>> > +
>> >  struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>> >  {
>> >         struct avrcp *session;
>> > @@ -241,6 +299,8 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>> >                                                         handle_vendordep_pdu,
>> >                                                         session);
>> >
>> > +       avrcp_set_control_handlers(session, control_handlers, NULL);
>> > +
>> >         return session;
>> >  }
>> >
>> > diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
>> > index 4f3a632..0821287 100644
>> > --- a/android/avrcp-lib.h
>> > +++ b/android/avrcp-lib.h
>> > @@ -46,6 +46,18 @@
>> >  #define AVRCP_ADD_TO_NOW_PLAYING       0x90
>> >  #define AVRCP_GENERAL_REJECT           0xA0
>> >
>> > +/* Notification events */
>> > +#define AVRCP_EVENT_STATUS_CHANGED             0x01
>> > +#define AVRCP_EVENT_TRACK_CHANGED              0x02
>> > +#define AVRCP_EVENT_TRACK_REACHED_END          0x03
>> > +#define AVRCP_EVENT_TRACK_REACHED_START                0x04
>> > +#define AVRCP_EVENT_SETTINGS_CHANGED           0x08
>> > +#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED  0x0a
>> > +#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED   0x0b
>> > +#define AVRCP_EVENT_UIDS_CHANGED               0x0c
>> > +#define AVRCP_EVENT_VOLUME_CHANGED             0x0d
>> > +#define AVRCP_EVENT_LAST                       AVRCP_EVENT_VOLUME_CHANGED
>> > +
>> >  struct avrcp;
>> >
>> >  struct avrcp_control_handler {
>> > --
>> > 1.8.3.2
>>
>> That is the actual AVRCP implementation not the library, the library
>> only offer means to handle the commands but don't parse it there since
>> we can't do anything with it. For unit tests you can implement dummy
>> handlers as we did for passthrough.
>
> I can implement dummy handlers but this would mean that we are testing
> that dummy handlers. Is the idea to test actual production code?

Which is fine, the capabilities will anyway depend on the underline
player implementation so a dummy one is fine here, in fact the unit
tests should not care what is the capabilities just that the PDU is
formed correctly.


-- 
Luiz Augusto von Dentz
