Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCA1773D
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469700; cv=pass; b=g6FR0t5MZFjrH367bd+qtIAw6pa56JBjL2J2QUgTH6zFSYOcu6RlFyloxxhwtyjSSxtinK7ukrwvo6Wa66lKV0wz12PkAEQ6GmwcZ2RIBdp1oxfTwBiRORr98wg/M9ucjxpLkJyfugFCJqGABqwXmSKuU6ciehAfU3wLHQvCXwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469700; c=relaxed/simple;
	bh=WqWO4TgQNhu9Jaecj9a4M1ogkCXw9qQcU1ytuWCHTlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShbXiU3WrtneXdqKQJV7KXQ+QJdzKZySF+IDyvhW2VGUcEXnl9v40ETviTchKvs28LjaV9jdGtF4Tu1T7FVbDgdV7e0Wq800dE6vFONtkU8hDsMPbst/BgZTMI7QhLQ9iTpgkNCAkneFD7XGUrrKv0O915tVIENZKmGwz0ij0VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=hWAK1P98; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="hWAK1P98"
ARC-Seal: i=1; a=rsa-sha256; t=1725469696; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=clbDJkVfn2iSl4UV4sQbs+vVJwqORchuT6x3GsCY7Opbwprs1ziP30lmdSIOg2ztyAkuzmUmuizEEDVRa6TE4PUscg+bememkKl4SBVNzidcDA4QK+zHe+sNipEIAq6SrD5rZXyAY6pY0qY7SfaACtHqQGLPXBFnHwUSDODEwJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725469696; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dNyHfn2JdtIHBiYul2VpsupgcSoKNshiyGu+8q7I58E=; 
	b=eVRJDpFbsW6XGhtr5+bLd8Hqb1sjKpeQGtYxq1W40bJoPVpKEI1ybahNJEFE7ZFuINT2DmB6nMpP3KDtJvgtJHxIK18p8N0C8gX0OK4o6DZIa1iknffyWEPw7PwV5XHZf5Vg7M/ch5i+vUsZ+OJSuo1ADA0vMHS0BcY2fJ1ekBQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725469696;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dNyHfn2JdtIHBiYul2VpsupgcSoKNshiyGu+8q7I58E=;
	b=hWAK1P98TH45Oo7SbxWQpNF7nKAvwNFsVRcm9Lezi3QItUCySwNIeZjn982NweDs
	xUiwE0s1BkpGxWGM/FY8ClVlpjNhcV1VOJdsZH+rjhTp5h2VJZjmhtTRDWUyTcUMcz5
	lYword+zot/U6vQ01kwWY8DXJ+LcGIrVlXAEPCTU=
Received: by mx.zohomail.com with SMTPS id 1725469694477793.0696874434612;
	Wed, 4 Sep 2024 10:08:14 -0700 (PDT)
Message-ID: <bcef82e3-5944-4b46-b931-d6dd009392d5@collabora.com>
Date: Wed, 4 Sep 2024 19:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/7] player: Add OBEX PSM port for cover art support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240904140421.283166-1-frederic.danis@collabora.com>
 <20240904140421.283166-3-frederic.danis@collabora.com>
 <CABBYNZ+C6R7TSDtUj0kOwPPioBDx9u92TRSx1Je-UB4iS2jZqQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZ+C6R7TSDtUj0kOwPPioBDx9u92TRSx1Je-UB4iS2jZqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 04/09/2024 17:14, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Wed, Sep 4, 2024 at 10:33 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> This parse the AVRCP Target SDP record for the L2CAP PSM to use with
>> the OBEX session to get the cover art.
>> ---
>>   doc/org.bluez.MediaPlayer.rst |  6 +++++
>>   profiles/audio/avrcp.c        | 51 +++++++++++++++++++++++++++++++----
>>   profiles/audio/player.c       | 29 ++++++++++++++++++++
>>   profiles/audio/player.h       |  1 +
>>   4 files changed, 82 insertions(+), 5 deletions(-)
>>
>> diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
>> index 60bd679bb..f1e999bdf 100644
>> --- a/doc/org.bluez.MediaPlayer.rst
>> +++ b/doc/org.bluez.MediaPlayer.rst
>> @@ -313,3 +313,9 @@ object Playlist
>>   ```````````````
>>
>>          Playlist object path.
>> +
>> +uint16 ObexPort [readonly]
>> +`````````````````````````````
>> +
>> +       If present indicates the player can get cover art using BIP over OBEX
>> +       on this PSM port.
> Id pass this via as part of URL e.g. obex://<address>/handle:[port]
>
> That said, like I mentioned in the other change, we could perhaps
> attempt to load it directly from bluetoothd since obexd registered its
> profile with it the daemon will know that BIP has been registered and
> we could allow bluetoothd to create sessions/transfer via that
> connection rather than using the session D-Bus, it is a little more
> work compared to doing bluetoothctl but then we don't have to
> reimplement as part of upper layers or force the system to run
> bluetoothctl which is more like a testing tool to validate our API's,
> etc.

The image handle is available in the tack metadata only if the OBEX 
session is already connected.
So the L2CAP PSM is used before we get any image handle reference.

I may replace ObexPort property by ObexUrl with obex://<address>:<port> 
string.
Does it seems better?

Regarding the automatic load of the image, afaiu this will prevent the 
user application to select the format of the image.
The remote service may provide different formats of the image like 
thumbnail (200*200 JPEG), original format (whatever it is) or some other 
formats, e.g. 300*300 JPEG and 300*300 PNG.

> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 752e55be3..61558e492 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -118,8 +118,14 @@
>>   #define AVRCP_FEATURE_CATEGORY_2       0x0002
>>   #define AVRCP_FEATURE_CATEGORY_3       0x0004
>>   #define AVRCP_FEATURE_CATEGORY_4       0x0008
>> -#define AVRCP_FEATURE_PLAYER_SETTINGS  0x0010
>> -#define AVRCP_FEATURE_BROWSING                 0x0040
>> +#define AVRCP_FEATURE_TG_PLAYER_SETTINGS       0x0010
>> +#define AVRCP_FEATURE_TG_GROUP_NAVIGATION      0x0020
>> +#define AVRCP_FEATURE_BROWSING                         0x0040
>> +#define AVRCP_FEATURE_TG_MULTIPLE_PLAYER       0x0080
>> +#define AVRCP_FEATURE_TG_COVERT_ART                    0x0100
>> +#define AVRCP_FEATURE_CT_GET_IMAGE_PROP                0x0080
>> +#define AVRCP_FEATURE_CT_GET_IMAGE                     0x0100
>> +#define AVRCP_FEATURE_CT_GET_THUMBNAIL         0x0200
>>
>>   #define AVRCP_BATTERY_STATUS_NORMAL            0
>>   #define AVRCP_BATTERY_STATUS_WARNING           1
>> @@ -254,6 +260,7 @@ struct avrcp_data {
>>          struct avrcp_player *player;
>>          uint16_t version;
>>          int features;
>> +       uint16_t obex_port;
>>          GSList *players;
>>   };
>>
>> @@ -487,7 +494,7 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
>>                                          AVRCP_FEATURE_CATEGORY_2 |
>>                                          AVRCP_FEATURE_CATEGORY_3 |
>>                                          AVRCP_FEATURE_CATEGORY_4 |
>> -                                       AVRCP_FEATURE_PLAYER_SETTINGS );
>> +                                       AVRCP_FEATURE_TG_PLAYER_SETTINGS);
>>
>>          record = sdp_record_alloc();
>>          if (!record)
>> @@ -3522,6 +3529,7 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
>>                  return NULL;
>>          }
>>
>> +       media_player_set_obex_port(mp, session->controller->obex_port);
>>          media_player_set_callbacks(mp, &ct_cbs, player);
>>          player->user_data = mp;
>>          player->destroy = (GDestroyNotify) media_player_destroy;
>> @@ -4006,7 +4014,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>>          if (events == (1 << AVRCP_EVENT_VOLUME_CHANGED))
>>                  return FALSE;
>>
>> -       if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
>> +       if ((session->controller->features &
>> +                       AVRCP_FEATURE_TG_PLAYER_SETTINGS) &&
>>                          !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>>                  avrcp_list_player_attributes(session);
>>
>> @@ -4075,8 +4084,9 @@ static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
>>   {
>>          struct avrcp_data *data;
>>          const sdp_record_t *rec;
>> -       sdp_list_t *list;
>> +       sdp_list_t *list, *protos;
>>          sdp_profile_desc_t *desc;
>> +       int port = 0;
>>
>>          data = g_new0(struct avrcp_data, 1);
>>
>> @@ -4092,6 +4102,35 @@ static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
>>          sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES, &data->features);
>>          sdp_list_free(list, free);
>>
>> +       if ((g_strcmp0(uuid, AVRCP_TARGET_UUID) != 0) ||
>> +                       !(data->features & AVRCP_FEATURE_TG_COVERT_ART) ||
>> +                       (sdp_get_add_access_protos(rec, &protos) != 0))
>> +               return data;
>> +
>> +       /* Get the PSM port from the Additional Protocol Descriptor list
>> +        * entry containing OBEX UUID
>> +        */
>> +       for (list = protos; list; list = list->next) {
>> +               sdp_list_t *p;
>> +
>> +               for (p = list->data; p; p = p->next) {
>> +                       sdp_data_t *seq = p->data;
>> +
>> +                       if ((sdp_uuid_to_proto(&seq->val.uuid) == OBEX_UUID) &&
>> +                                       SDP_IS_UUID(seq->dtd)) {
>> +                               port = sdp_get_proto_port(list, L2CAP_UUID);
>> +                               goto done;
>> +                       }
>> +               }
>> +       }
>> +
>> +done:
>> +       if (port > 0)
>> +               data->obex_port = port;
>> +
>> +       sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
>> +       sdp_list_free(protos, NULL);
>> +
>>          return data;
>>   }
>>
>> @@ -4189,6 +4228,8 @@ static void controller_init(struct avrcp *session)
>>          session->controller = controller;
>>
>>          DBG("%p version 0x%04x", controller, controller->version);
>> +       if (controller->obex_port)
>> +               DBG("%p OBEX PSM 0x%04x", controller, controller->obex_port);
>>
>>          service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
>>          btd_service_connecting_complete(service, 0);
>> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
>> index c995697fe..4e3de8047 100644
>> --- a/profiles/audio/player.c
>> +++ b/profiles/audio/player.c
>> @@ -88,6 +88,7 @@ struct media_player {
>>          struct player_callback  *cb;
>>          GSList                  *pending;
>>          GSList                  *folders;
>> +       uint16_t                obex_port;
>>   };
>>
>>   static void append_track(void *key, void *value, void *user_data)
>> @@ -437,6 +438,28 @@ static gboolean get_playlist(const GDBusPropertyTable *property,
>>          return TRUE;
>>   }
>>
>> +static gboolean obexport_exists(const GDBusPropertyTable *property,
>> +                                                               void *data)
>> +{
>> +       struct media_player *mp = data;
>> +
>> +       return mp->obex_port != 0;
>> +}
>> +
>> +static gboolean get_obexport(const GDBusPropertyTable *property,
>> +                                       DBusMessageIter *iter, void *data)
>> +{
>> +       struct media_player *mp = data;
>> +
>> +       if (mp->obex_port == 0)
>> +               return FALSE;
>> +
>> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
>> +                                                       &mp->obex_port);
>> +
>> +       return TRUE;
>> +}
>> +
>>   static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
>>                                                                  void *data)
>>   {
>> @@ -778,6 +801,7 @@ static const GDBusPropertyTable media_player_properties[] = {
>>          { "Browsable", "b", get_browsable, NULL, browsable_exists },
>>          { "Searchable", "b", get_searchable, NULL, searchable_exists },
>>          { "Playlist", "o", get_playlist, NULL, playlist_exists },
>> +       { "ObexPort", "q", get_obexport, NULL, obexport_exists },
>>          { }
>>   };
>>
>> @@ -1997,3 +2021,8 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
>>
>>          return item;
>>   }
>> +
>> +void media_player_set_obex_port(struct media_player *mp, uint16_t port)
>> +{
>> +       mp->obex_port = port;
>> +}
>> diff --git a/profiles/audio/player.h b/profiles/audio/player.h
>> index 74fb7d771..0076c4641 100644
>> --- a/profiles/audio/player.h
>> +++ b/profiles/audio/player.h
>> @@ -86,6 +86,7 @@ void media_player_set_folder(struct media_player *mp, const char *path,
>>   void media_player_set_playlist(struct media_player *mp, const char *name);
>>   struct media_item *media_player_set_playlist_item(struct media_player *mp,
>>                                                                  uint64_t uid);
>> +void media_player_set_obex_port(struct media_player *mp, uint16_t port);
>>
>>   struct media_item *media_player_create_folder(struct media_player *mp,
>>                                                  const char *name,
>> --
>> 2.34.1
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

