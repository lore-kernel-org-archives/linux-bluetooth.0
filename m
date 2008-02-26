Return-Path: <cyrus@holtmann.org>
Message-Id: <9B6FD5D3-CFDE-4F5F-91A7-3A64B653DD78@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1204053578.6888.47.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Tue, 26 Feb 2008 20:28:09 +0100
References: <47666E1F.2000902@mizi.com>
	<d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
	<1204053578.6888.47.camel@localhost>
Subject: Re: [Bluez-devel] forcing SCO connection patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Guillaume,

>> Marcel looked at this patch and came back with the comments below.  
>> Can
>> you revisit it? I think some other people are seeing the same issues.
>> The patch won't go upstream until Marcel likes it.
>>
>> the patch you sent me is fully broken. First of all the coding style
>> is wrong. Does nobody have learned this by now? I always look for  
>> that
>> first before even reading the patch. Second the case where an
>> ESCO_LINK returns NULL is broken and will fall over and crash.
>>
> It was about the patch on the wiki (one of mine, shame on me).
>
> Marcel is right, this patch is an awful and moreover buggy patch  
> (and I
> found nothing in the specification stating a SCO connection shall be
> opened as a fallback for an eSCO one, or shall not, so I abandonned  
> that
> way).
>
> However, I think the first patch
> (force-sco-link-until-headset-features-are-known.patch), despite badly
> styled and named, was correct.

No. That is wrong. Using sync setup commands apply to SCO and eSCO. No  
need to force anything here. Let the Bluetooth firmware inside the  
chip do the right thing.

> Everywhere I found a eSCO feature test for the local device, I added a
> test for the remote device eSCO/EV3 feature.
>
> An eSCO connection is then used only when both the local and the  
> remote
> devices supports the feature, else a SCO connection is requested with
> headsets not supporting eSCO.

As I said, wrong approach. Don't put that logic into the host stack.  
Let the firmware negotiate that.

> The headset's features mask should be already available, as the  
> request
> is sent just after establishing the underlying ACL connection.
>
> And it shall be known before establishing a synchronous connection  
> with
> the right packet type(s), according to the spec (maybe we should  
> ensure
> we get a response to this features request ?).
>
> I tried to fix style issues in this new patch, let me now if some
> remain.
>
> The other patch (also-accept-sco-links-v2.patch) is not needed at all,
> as the case should not occur anymore with the attached patch applied.

Wrong. This case can still happen. Nobody says that the remote device  
has to establish an eSCO link only because the link manager feature  
says that the chip supports. In short it means that if the host stack  
on the remote doesn't want eSCO that is perfectly fine and valid.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
