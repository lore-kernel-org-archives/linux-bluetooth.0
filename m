Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <02ed01d10b3f$13ee3b00$3bcab100$@samsung.com>
References: <1444639277-5998-1-git-send-email-bharat.panda@samsung.com>
	<02ec01d10b38$052f11e0$0f8d35a0$@samsung.com>
	<56263F0B.6010807@canonical.com>
	<02ed01d10b3f$13ee3b00$3bcab100$@samsung.com>
Date: Tue, 20 Oct 2015 21:18:52 +0300
Message-ID: <CABBYNZ+JD3KcknEKW8d4GoG7k3eXDxdtdhAzSZngLnupZZ3akg@mail.gmail.com>
Subject: Re: [PATCH ] audio/player: Fix player name value for MPRIS
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: Simon Fels <simon.fels@canonical.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Oct 20, 2015 at 4:55 PM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> Hi Simon,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Simon Fels
>> Sent: Tuesday, October 20, 2015 6:48 PM
>> To: Bharat Bhusan Panda; linux-bluetooth@vger.kernel.org
>> Cc: cpgs@samsung.com
>> Subject: Re: [PATCH ] audio/player: Fix player name value for MPRIS
>>
>> On 20.10.2015 15:05, Bharat Bhusan Panda wrote:
>> > ping
>> >
>> >> -----Original Message-----
>> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> >> owner@vger.kernel.org] On Behalf Of Bharat Panda
>> >> Sent: Monday, October 12, 2015 2:11 PM
>> >> To: linux-bluetooth@vger.kernel.org
>> >> Cc: cpgs@samsung.com; Bharat Panda
>> >> Subject: [PATCH ] audio/player: Fix player name value for MPRIS
>> >>
>> >> Added fix for setting media player name when the player Identity
>> >> value is invalid.
>> >> ---
>> >>   profiles/audio/media.c | 15 +++++++++++++--
>> >>   tools/mpris-proxy.c    |  1 +
>> >>   2 files changed, 14 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
>> >> 69070bf..68111e6 100644
>> >> --- a/profiles/audio/media.c
>> >> +++ b/profiles/audio/media.c
>> >> @@ -1805,7 +1805,7 @@ static DBusMessage
>> >> *register_player(DBusConnection *conn, DBusMessage *msg,
>> >>    struct media_adapter *adapter = data;
>> >>    struct media_player *mp;
>> >>    DBusMessageIter args;
>> >> -  const char *sender, *path;
>> >> +  const char *sender, *path, *name;
>> >>    int err;
>> >>
>> >>    sender = dbus_message_get_sender(msg); @@ -1814,6 +1814,8 @@
>> >> static DBusMessage *register_player(DBusConnection *conn,
>> DBusMessage
>> >> *msg,
>> >>
>> >>    dbus_message_iter_get_basic(&args, &path);
>> >>    dbus_message_iter_next(&args);
>> >> +  dbus_message_iter_get_basic(&args, &name);
>> >> +  dbus_message_iter_next(&args);
>> >>
>> >>    if (media_adapter_find_player(adapter, sender, path) != NULL)
>> >>            return btd_error_already_exists(msg); @@ -1831,6 +1833,14
>> @@
>> >> static DBusMessage *register_player(DBusConnection *conn,
>> DBusMessage
>> >> *msg,
>> >>            return btd_error_invalid_args(msg);
>> >>    }
>> >>
>> >> +  /*
>> >> +   * The Player Identity value is NULL in MPRIS case, so create
>> >> +   * mpris name on the basis of player bus name and assign
>> >> +   * the value.
>> >> +   */
>> >> +  if (mp->name == NULL)
>> >> +          mp->name = g_strdup(name);
>> >> +
>> >>    return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);  }
>> >>
>> >> @@ -1864,7 +1874,8 @@ static const GDBusMethodTable
>> media_methods[] =
>> >> {
>> >>    { GDBUS_METHOD("UnregisterEndpoint",
>> >>            GDBUS_ARGS({ "endpoint", "o" }), NULL,
>> >> unregister_endpoint) },
>> >>    { GDBUS_METHOD("RegisterPlayer",
>> >> -          GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" }),
>> >> +          GDBUS_ARGS({ "player", "o" }, { "name", "s" },
>> >> +                                          { "properties", "a{sv}" }),
>>
>> This breaks the API. Can't the name be passed as a member of the
> properties
>> dict?

We are not going to break the API that is for sure, so if there is no
Identity we should probably come up with a good default.

> It can be passed in properties dict, but again as per mpris spec there is no
> properties defined for name but it can be tweaked at mpris-proxy and passed
> to media player.
> Not sure which approach will be better to pass the name field.

Actually there is, it is the bus name if Im not mistaken.

>> regards,
>> Simon
>>
> Regards,
> Bharat
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
