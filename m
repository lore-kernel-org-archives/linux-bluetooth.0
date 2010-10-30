Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101029205033.GB14961@vigoh>
References: <linux-bluetooth@vger.kernel.org>
	<1287791820-22693-3-git-send-email-anderson.briglia@openbossa.org>
	<20101029104435.GQ15050@null>
	<AANLkTimTUFK9id6kQyggt_xWsB-RspwbPoB4m39XU2cP@mail.gmail.com>
	<20101029205033.GB14961@vigoh>
Date: Sat, 30 Oct 2010 00:31:37 -0300
Message-ID: <AANLkTimVb4z5CkykTuGW0ug_eTtJKP+ZDvwyjcGcmCaX@mail.gmail.com>
Subject: Re: [PATCH 2/6] Bluetooth: fix receiving L2CAP packets over LE
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Ville Tervo <ville.tervo@nokia.com>,
	ext Anderson Briglia <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Oct 29, 2010 at 5:50 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi,
>
> * Vinicius Gomes <vinicius.gomes@openbossa.org> [2010-10-29 09:41:55 -0400]:
>
>> Hi Ville,
>>
>> On Fri, Oct 29, 2010 at 6:44 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
>> > Hi Anderson,
>> >
>> > On Sat, Oct 23, 2010 at 01:56:56AM +0200, ext Anderson Briglia wrote:
>> >> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>> >>
>> >> As L2CAP packets coming over LE don't have any more encapsulation,
>> >> other than L2CAP, we are able to process them as soon as they arrive.
>> >
>> > Why is this change needed? Was something broken without this patch?
>> >
>>
>> This change is needed because without it the receiving side would
>> always think that it was receiving continuation frames.
>>
>> As the flags parameter is zero, it would fall into the "} else {"
>> condition, and because no frame was received before, conn->rx_len
>> would be zero and the frame would be discarded. Without this patch I
>> was seeing those "Unexpected continuation frame ..." messages on the
>> receiving side.
>
> From what I understood the flags are only for ACL connections and LE
> links doesn't have fragmentation, right? So we don't need to check flags
> here, actually it seems we don't have flags for LE like ACL.
>

Yeah, that is what the patch tries to solve. I was just trying to make
clear why the old code doesn't work (seems that I didn't do a good job
;-) .

> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>


Cheers,
-- 
Vinicius
