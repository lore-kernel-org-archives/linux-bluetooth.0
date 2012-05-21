Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B234A45A602@EXDCVYMBSTM005.EQ1STM.local>
References: <1336990615-24344-1-git-send-email-vani.patel@stericsson.com>
	<CABBYNZ+_AozCS3GD1Q19gZux-YrF-_Bh1udRW0D+MkNfYC4+SA@mail.gmail.com>
	<747C1E83C744F44E9ACFB89FAEEC2C7B234A45A602@EXDCVYMBSTM005.EQ1STM.local>
Date: Mon, 21 May 2012 17:10:42 +0300
Message-ID: <CABBYNZLYtXTq_=Sg_Gma2=Rp6oqZZmakZydJnDei5LEmLTCoHg@mail.gmail.com>
Subject: Re: [PATCH Bluez v2 1/4] AVRCP: Register for VolumeChanged Notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Mon, May 21, 2012 at 4:51 PM, Vani-dineshbhai PATEL X
<vani.patel@stericsson.com> wrote:
> Hi Luiz,
>
>> >
>> >  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
>> > +void register_volume_notification ( struct avctp *session);
>> > --
>> > 1.7.5.4
>>
>> I had to change it completely to make it work, Im afraid you never
>> really tested this as it did not compile for me, were you using
>> bootstrap-configure?
>>
>
> The code is compiling perfectly at my end and I have tested it several times with PTS before pushing it. I follow below steps to compile my code -
>
>  autoreconf --install
> ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --libexecdir=/lib
>  make
>  make install
>
> I also compiled and tested my code using bootstrap-configure by following below steps.
>
> ./bootstrap
> ./bootstrap-configure
> ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --libexecdir=/lib
> make
> make install
>
> Had I known that you were facing compiling issues with my code earlier, I would have published the procedure how I have been compiling the code.
> It would be really nice if you could point any issues with my procedure of compiling & testing the code, so that I can adapt to the correct procedure and follow for any future updates.

Don't call configure after bootstrap-configure since it is already
done and you are not setting --enable-maintainer-mode, also please
consider using the following in your .git/hooks/pre-commit:
exec git diff --cached | ~/pathto/checkpatch.pl --no-signoff -

There were not only compilation problems but a lot of code style
problems as well.


-- 
Luiz Augusto von Dentz
