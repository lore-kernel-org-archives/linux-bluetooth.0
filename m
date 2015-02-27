Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1758603.Tr6JIHPuTr@uw000953>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
	<1425049274-11552-6-git-send-email-szymon.janc@tieto.com>
	<CAJLTA8gDLn-AkGHfCyye4s_RHL5=pcrMVSFtA4dTac3cHXxoeQ@mail.gmail.com>
	<1758603.Tr6JIHPuTr@uw000953>
Date: Fri, 27 Feb 2015 18:02:09 +0200
Message-ID: <CABBYNZLXm_wkOwfBF4Ro1Qx6LqZChMd8n+ooiZEJJwz7u_kikw@mail.gmail.com>
Subject: Re: [PATCH 6/6] shared/att: Fix signed write without transparent signing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Michael Janssen <jamuraa@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 27, 2015 at 5:27 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Michael,
>
> On Friday 27 of February 2015 07:21:51 Michael Janssen wrote:
>> Hi Szymon,
>>
>> On Fri, Feb 27, 2015 at 7:01 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> > If local key wasn't set by bt_att_set_local_key() assume that signing
>> > is done by bt_att_send() caller ie. gattrib code.
>> > ---
>> >  src/shared/att.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/src/shared/att.c b/src/shared/att.c
>> > index 9787377..b20af21 100644
>> > --- a/src/shared/att.c
>> > +++ b/src/shared/att.c
>> > @@ -308,7 +308,7 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
>> >
>> >         sign = att->local_sign;
>> >         if (!sign)
>> > -               goto fail;
>> > +               true;
>>
>> This should be 'return true;' I think?
>
> Good catch. I've got this right locally but forgot to amend before generating
> patch :)

Yep, but as discussed in the IRC there are more problems with it
because we increase the data length before this, I guess we are doing
to need some refactoring to fix this properly.


-- 
Luiz Augusto von Dentz
