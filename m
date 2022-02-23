Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C690AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiBWWNT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiBWWNS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 17:13:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06F4F471
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 14:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645654367;
        bh=Pu7JU/CQUzDb9woGaLZEQIOi3GF8xDhxUbqB3fyhwiI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WMDjiUgTjcSC8laZum3IWCoMMVku2OutKMFMDz1lxktuMcgydF1Vbc883FHWP5a8T
         riQyxtPXcc8QLD25R6v//YELDj9RFuei5CsO8CY6/GoniEyv1gzgDI7voBEXOG+JSJ
         E3KTGjCG579go42h0G8AcCPXMdN6R7WXZAsSWOTU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.56] ([37.4.228.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1nugjQ0iO7-00bNgN; Wed, 23
 Feb 2022 23:12:47 +0100
Message-ID: <c692d560-af17-7a6e-c53e-36aa0c9501dc@gmx.de>
Date:   Wed, 23 Feb 2022 23:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH BlueZ] Use audio-card-bluetooth icon
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20211223175005.52976-1-nicolas.fella@gmx.de>
 <CABBYNZL4ftQ7PCMPywddoZvPcu_D9xkx21o=Bo=g9DtZ=vJStg@mail.gmail.com>
From:   Nicolas Fella <nicolas.fella@gmx.de>
In-Reply-To: <CABBYNZL4ftQ7PCMPywddoZvPcu_D9xkx21o=Bo=g9DtZ=vJStg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vKSV4Cn9jVp+JskwkxB4dLlxVkiaPQcss4apec3Dlsr8BylT/t+
 xmwWcVKa3ipXOm+GoOqSFdM+QBZSZoxMCXwmd0UmvM0XuUIgPkRMGBo08Si4q/IsfAsvAbE
 GVV0vT5vwS4s3mpVjQHSeZ8Rw2K+2oWXKBIhDvzofU+hIflKLEjkYViY78qYsEh8d9ujEaj
 gOQw7knkDpupQX3NiXyWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M3AIa7C1JZs=:1H0Rf9KCeFMMPv/c19kajC
 pChnm+xzBB1ed5+ZoyVEz+DlDk0XvcaFCjNHbXfmjSPe+HKrdz82tCitDIiqLL9p6kndz2i5B
 91wm5KxXLiww3TRGO7uUF6CecmqQH2uivJ9X+W1f+iotGAKnYWKAfs34U/vSPSBc1BBsXqxKc
 kRK+mMZg5lCT5k+iSR6ODikZBfysHueilz+8jsGDw+5/AD1AkqZx98kdFH76H765oO/UZALUy
 OOgR7gf0KQ/mvDRHW75c5S+TqMn4KSJAHaSi4Bgn2OHNLaY++ctMPhwoZMduQPPdpKGM5Z40E
 WwwIT/K58K9IO/aVS5LBQmd8wY1F+VmiSns8U/C0S48rlk/YimGcLItssCJi1rSUtNYwCWUmI
 IxaMKhoC6P6ifj9CmzSTaiEOUReD1WBxRnqcze8E8dwdMMvNIoOtc3fliXOjwugUEpYWaVgIA
 mxMGz9MLOliuUAFUalhz8C1Trhhe2iVvY1j/+3b924pnQ1Gmyp7ZK5HLm9YWqkuAJdoTv+4D1
 dM8YrrPzw0RFxIyPSTR2yWGhCL3SB4mYxF4/iLY4UykqWpz52ArWKNQfNMK5vG7osmXrNOT/m
 dFdQbMvJjraxLqze15gA5tOKtOrASFhk7Cko25Uy9FpcH7U7tB7CNXPGPvQebE6+6UxFw6eMV
 Y0rwO3lc2kJuOvl+atDPlKu5q0nZns1uH2Z7yR62z+5EoJI2Sd7sqbEkETBYBRQ0sEAUMN9TR
 Rsse5XPauUZiKjiX3F+DF/nSFAAtySDI6l+fHHImAf5EWvQYTwayhw6rVYWz50BRLNNA3797C
 +lmYtiW4XAq9Q3Hy2q+Yhiq0okQuj+vb1A+AhkmuwbvrBmzyyRxdQFvTrOUxW0aOTpbTkJP26
 nbtQOjS57brAiRPKcetUARIzWTP5n8koYwSGu04cnTg5AH65GkjppQzHdsMMi6ZSEhvx/Zs4T
 ygOYD0v05S/13W0eGWnvsp5nvbYZB6gULha/VGCJOn7PYYfsYa44EeOEYt5dS09zZdZ7ibOmn
 OFyOIuL0elAjkSrpzBc3GdnNvUUFvPGBiWJn/v9/RJGILVHxmFKNE3JFR2eNZAe8EsqRFzWqh
 gPEmw7npOi+d9g=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On 1/5/22 20:07, Luiz Augusto von Dentz wrote:
> Hi Nicolas,
>
> On Fri, Dec 24, 2021 at 5:06 PM Nicolas Fella <nicolas.fella@gmx.de> wro=
te:
>> PulseAudio uses this icon for this kind of device
>>
>> Let's be consistent
>>
>> Users will gracefully fall back to audio-card if audio-card-bluetooth
>> is not found
>> ---
>>   src/dbus-common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/dbus-common.c b/src/dbus-common.c
>> index 5e2c83d52..3611cb013 100644
>> --- a/src/dbus-common.c
>> +++ b/src/dbus-common.c
>> @@ -80,7 +80,7 @@ const char *class_to_icon(uint32_t class)
>>                  case 0x0d: /* Camcorder */
>>                          return "camera-video";
>>                  default:
>> -                       return "audio-card";    /* Other audio device *=
/
>> +                       return "audio-card-bluetooth";  /* Other audio =
device */
>>                  }
>>                  break;
>>          case 0x05:
>> --
>> 2.34.1
> It doesn't seem to be part of
> https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.h=
tml,
> does the icon themes really have such icon?

I can't name any theme that does. There is a request to add it to Breeze
in https://bugs.kde.org/show_bug.cgi?id=3D447431.

If a theme doesn't have audio-card-bluetooth a compliant implementation
will fall back to audio-card, so using it won't hurt.

We have a bit of a chicken-and-egg situation here. Without bluez using
the icon there is less incentive to add it to icon themes.

Cheers

Nicolas


