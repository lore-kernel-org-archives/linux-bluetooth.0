Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikzecKtx3ib-03n3f8_2u4KF0Y+PSmEJgccEg-i@mail.gmail.com>
References: <AANLkTikzecKtx3ib-03n3f8_2u4KF0Y+PSmEJgccEg-i@mail.gmail.com>
Date: Fri, 29 Oct 2010 16:16:03 +0300
Message-ID: <AANLkTi=_1qAiH9o_4eBy66OQ9=ba=4GuatVBVtcJG5=x@mail.gmail.com>
Subject: Re: [RFC] AVRCP 1.4 : Design proposal for future on Target Role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "shivendra.agrawal@stericsson.com" <ag.shivendra@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 27, 2010 at 11:23 AM, shivendra.agrawal@stericsson.com
<ag.shivendra@gmail.com> wrote:
> Hi All,
>
> ST-Ericsson plans to implement the commands to support target role of
> AVRCP 1.4 Profile, and we would like to contribute it to BlueZ.
> With our initial discussion, I would be aligning with BlueZ
> contributors and would propose for the ideas that has not been
> touched/developed so far, in order to have a design/implementation
> that can be accepted.
>
> As a very first, and very rough, design proposal for the BlueZ parts:
> - A new SDP record for AVRCP 1.4 would be added to inform CT of the
> version and features supported by target.
> - A new callback to accept browsing channel establishment.
> - Enhancing similar to bt_io_listen for browsing PSM.
> - A new browsing command handler
> - Incremental addition to AVRCP 1.4 commands.
>
> Any feedback is very much appreciated!
>
> Ref: Previous discussion subject: "AVRCP 1.4 : Future on Target Role"

I guess for all people that are interested in AVRCP 1.4 we can start
adding items to TODO list, to make it easier to share development
between us. Since this may be too much to handle in a single global
TODO maybe we can have a separated file like audio/TODO.

-- 
Luiz Augusto von Dentz
Computer Engineer
