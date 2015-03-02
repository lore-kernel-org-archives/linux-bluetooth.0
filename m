Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-J+Tr7AV6nQW9E_Hu+SZY=SCRj+C0Ftqump-espeS+AuA@mail.gmail.com>
References: <1425024072-6259-1-git-send-email-marcin.kraglak@tieto.com>
	<1425024072-6259-2-git-send-email-marcin.kraglak@tieto.com>
	<1432936.7iWJrZ6TN0@uw000953>
	<CABBYNZKwo3iLGhSB7+pEBhR6cWMK_GYmLSqgFb7FcGo1m-XEPA@mail.gmail.com>
	<CABD6X-J+Tr7AV6nQW9E_Hu+SZY=SCRj+C0Ftqump-espeS+AuA@mail.gmail.com>
Date: Mon, 2 Mar 2015 14:31:18 +0200
Message-ID: <CABBYNZJCnz8WZ7aHiSr3mao2V6Ad-_BzY=-fvA3DRthOETS8Xw@mail.gmail.com>
Subject: Re: [RFC] audio/avctp: Accept incoming connection in case of colission
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Mar 2, 2015 at 8:59 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Hi Luiz,
>
> Why do you want to move it to policy? As I understand policy is a way
> we want to improve user-experience, such connecting to default
> profiles etc., it's about channel establishment.

It is the policy module that takes care of connection logic, it is it
that does start the connection attempt once A2DP connects, in fact all
the policy does is connection policy so it can keep track what should
be connected or not and deal with reconnection logic, etc.

> On 27 February 2015 at 15:07, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Szymon,
>>
>> On Fri, Feb 27, 2015 at 12:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>> Hi Marcin,
>>>
>>> On Friday 27 of February 2015 09:01:12 Marcin Kraglak wrote:
>>>> Accept incoming connection to Control Channel in case of colission.
>>>> If accepting connection won't succeed, try reconnect.
>>>> There is no need to request authorization while user has been connecting
>>>> to service in meantime.
>>>> Issue was found during tests with NOKIA BH-505 and Motorola HT-820.
>>>> ---
>>>>  profiles/audio/avctp.c | 38 ++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
>>>> index 57071b5..8d457f4 100644
>>>> --- a/profiles/audio/avctp.c
>>>> +++ b/profiles/audio/avctp.c
>>>> @@ -203,6 +203,7 @@ struct avctp {
>>>>       uint8_t key_quirks[256];
>>>>       struct key_pressed key;
>>>>       bool initiator;
>>>> +     bool reconnect;
>>>>  };
>>>>
>>>>  struct avctp_passthrough_handler {
>>>> @@ -1219,11 +1220,22 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
>>>>       GError *gerr = NULL;
>>>>
>>>>       if (err) {
>>>> +             struct btd_device *device = session->device;
>>>> +             bool reconnect = session->reconnect;
>>>> +
>>>>               avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
>>>>               error("%s", err->message);
>>>> +
>>>> +             if (!reconnect)
>>>> +                     return;
>>>> +
>>>> +             DBG("Control: Attempting to reconnect");
>>>> +             avctp_connect(device);
>>>>               return;
>>>>       }
>>>>
>>>> +     session->reconnect = false;
>>>> +
>>>>       bt_io_get(chan, &gerr,
>>>>                       BT_IO_OPT_DEST, &address,
>>>>                       BT_IO_OPT_IMTU, &imtu,
>>>> @@ -1346,10 +1358,32 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
>>>>  {
>>>>       const bdaddr_t *src;
>>>>       const bdaddr_t *dst;
>>>> +     GError *err = NULL;
>>>>
>>>>       if (session->control != NULL) {
>>>> -             error("Control: Refusing unexpected connect");
>>>> -             g_io_channel_shutdown(chan, TRUE, NULL);
>>>> +             if (session->state != AVCTP_STATE_CONNECTING) {
>>>> +                     error("Control: Refusing unexpected connect");
>>>> +                     g_io_channel_shutdown(chan, TRUE, NULL);
>>>> +                     return;
>>>> +             }
>>>> +
>>>> +             /* Cancel outgoing connection and accept incoming */
>>>> +             DBG("Control: Accepting unexpected connect from remote");
>>>> +             g_io_channel_shutdown(session->control->io, TRUE, NULL);
>>>> +             g_io_channel_unref(session->control->io);
>>>> +             session->control->io = NULL;
>>>> +
>>>> +             if (!bt_io_accept(chan, avctp_connect_cb, session, NULL,
>>>> +                                                                     &err)) {
>>>> +                     error("bt_io_accept: %s", err->message);
>>>> +                     g_error_free(err);
>>>> +                     avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
>>>> +                     return;
>>>> +             }
>>>> +
>>>> +             session->reconnect = true;
>>>> +             session->control->io = g_io_channel_ref(chan);
>>>> +
>>>>               return;
>>>>       }
>>>
>>> I think we should go with random timer as required by AVRCP specification
>>>
>>> p.4.1.1:
>>> "If both devices open an AVCTP channel at the same time both channels shall be
>>> closed and each device shall wait a random time (not more than 1 s and not less
>>> than 100ms) and then try to open the AVCTP channel again. If it is known which
>>> device is the master that device can re-try at once."
>>
>> That and it is probably a better idea to leave this to policy to
>> re-try as it is already doing for A2DP.
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> BR
> Marcin Kraglak



-- 
Luiz Augusto von Dentz
