Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44171BC5C;
	Thu, 13 Mar 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860368; cv=none; b=VR+0PN6e9bEih0/fkvWiWM9DTg0bvTqKRPaAcqATHonMycX6vRvQ+K9sVZVlLmJJWNHk3v1UaJtCV8tPmX+vB7+imjLIgDpyH28eZ7BbaJO20s6RUpB836PLLU7H8o8IbCgyKRbI7KNzy6o2fe5SADrJN4oYXgMMmOpj9kxCwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860368; c=relaxed/simple;
	bh=cC0nh/U9veYZT9aicdNSer8j88qvzcp8ofb4Mx18/8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLEBg7GxuLa7jixtWkDekmEv6YFELGOnBj5MU4Xmu7u2Hd0Xcs8QbG9nMabpcMsVU6R8qbixDhTLumCFM38MldnfnYchzcwkigtkgMFxzYcZAdI97Q9S7K0ASmIWLutzOd1nnFbdOJ6RhHHOfnDyggxa89Gt/pgR6wdSpbho+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SW4ZITRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SW4ZITRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BFCC4CEDD;
	Thu, 13 Mar 2025 10:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741860368;
	bh=cC0nh/U9veYZT9aicdNSer8j88qvzcp8ofb4Mx18/8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SW4ZITRUMo5fN6mTcnPrOknpTpQsJ9W/X1qSnD9cPIkmcc8IloImMrJU0BTHqa4gT
	 TAtGP8pNyRTsj2TE5vNtexwTQTXf42UcD9TJz6k6aF9lZ+hLMqFXaJOEhQB7t3J27J
	 stjC4biow/9JaH7sSxrWckxL9ghbWVjykrH3DN14=
Date: Thu, 13 Mar 2025 11:06:04 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Chris Lu =?utf-8?B?KOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"ben@rs485.network" <ben@rs485.network>,
	Hao Qin =?utf-8?B?KOenpua1qSk=?= <Hao.Qin@mediatek.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"tiwai@suse.de" <tiwai@suse.de>,
	"luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"geraldogabriel@gmail.com" <geraldogabriel@gmail.com>,
	"g@b4.vu" <g@b4.vu>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Sean Wang <Sean.Wang@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix for MediaTek reset affecting Focusrite audio
 interfaces
Message-ID: <2025031352-octopus-quadrant-f7ca@gregkh>
References: <Z8ybO7DfeP3Ag9wz@m.b4.vu>
 <Z89YcqoED633dr_M@geday>
 <CABBYNZJCko6radLuW=M=jTzqUEr2rUoKc_TUBVWP9wFSgkKb6Q@mail.gmail.com>
 <d81e863b00b3153c1de1c782205713fa99a79308.camel@rs485.network>
 <e6e8d3fd-772b-4877-a4a6-9b3968a4c187@molgen.mpg.de>
 <a47e628e200d5200bec8cb7f59e72bcff298632f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a47e628e200d5200bec8cb7f59e72bcff298632f.camel@mediatek.com>

On Thu, Mar 13, 2025 at 09:05:16AM +0000, Chris Lu (陸稚泓) wrote:
> Hi Luiz,
> 
> Sorry for the late response.
> 
> On Thu, 2025-03-13 at 09:08 +0100, Paul Menzel wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > [Cc: +regressions, commit ccfc8948d7e4 was added in v6.11-rc1]
> > 
> > Am 13.03.25 um 02:43 schrieb Benedikt Ziemons:
> > > On Tue, 2025-03-11 at 21:53 -0400, Luiz Augusto von Dentz wrote:
> > 
> > > > On Mon, Mar 10, 2025 at 5:24 PM Geraldo Nascimento wrote:
> > > > > 
> > > > > On Sun, Mar 09, 2025 at 06:02:11AM +1030, Geoffrey D. Bennett
> > > > > wrote:
> > > > > > This series (choose 1 of the 2 patches) addresses an issue
> > > > > > where the
> > > > > > MT7922 Bluetooth controller reset added in commit
> > > > > > ccfc8948d7e4
> > > > > > ("Bluetooth: btusb: mediatek: reset the controller before
> > > > > > downloading
> > > > > > the fw") is causing Focusrite USB audio devices to fail to
> > > > > > initialise
> > > > > > when connected during boot on kernels 6.11 and newer.
> > > > > > 
> > > > > > Reported by three users here:
> > > > > > https://urldefense.com/v3/__https://github.com/geoffreybennett/linux-fcp/issues/24__;!!CTRNKA9wMg0ARbw!hovfaKcQBzFKUu7X62SNU_berXiuXtSb2ndXGjAyf9WCptdz3D8jnprUqYc6b2fQE_3zrt88nGpKtJcYUCCcdA$
> > > > > > 
> > > > > > Two users confirmed they have an MT7922.
> > > > > > 
> > > > > > I'm providing two possible solutions as I note there was a
> > > > > > similar
> > > > > > change made in commit a7208610761a ("Bluetooth: btmtk: Remove
> > > > > > resetting mt7921 before downloading the fw"), so I'm not sure
> > > > > > if the
> > > > > > reset should be reverted for the MT7925 as well as the
> > > > > > MT7922.
> > > > > > 
> > > > > > Option 1: Revert the problematic reset behaviour entirely
> > > > > > (MT7922 +
> > > > > > MT7925)
> > > > > > 
> > > > > > Option 2: Remove the reset only for the MT7922
> > > > > > 
> > > > > > Geoffrey D. Bennett (2):
> > > > > > 
> > > > > >    [PATCH 1/2] Revert "Bluetooth: btusb: mediatek: reset the
> > > > > > controller
> > > > > >      before downloading the fw"
> > > > > > 
> > > > > >    [PATCH 2/2] Bluetooth: btmtk: Remove resetting mt7922
> > > > > > before
> > > > > >      downloading the fw
> > > > > > 
> > > > > > --
> > > > > > 2.45.0
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Hi Geoffrey,
> > > > > 
> > > > > I understand there's no apparent nexus of causality here.
> > > > > 
> > > > > However if three different users suddenly reported the same
> > > > > problem
> > > > > and the fix fixes it, we should take the report seriously and
> > > > > back
> > > > > down on the problematic commit until we figure for sure what
> > > > > the heck
> > > > > is going on.
> > > > > 
> > > > > My bet is this is bona fide bug in the USB subsystem, but
> > > > > either I'm
> > > > > not looking hard enough or I'm looking into the wrong places,
> > > > > because
> > > > > there's no way I can see in which way USB bluetooth driver from
> > > > > MediaTek could cause clock detection to fail.
> > > > > 
> > > > > No point in pressing this harder, but yeah, take the reports
> > > > > more than
> > > > > seriously, because if we don't understand in which way our own
> > > > > (Linux)
> > > > > code could be causing this, at least we should take cautionary
> > > > > measures.
> > > > > 
> > > > > In that sense, putting Takashi Iwai and Greg KH to Cc: in a
> > > > > modest but
> > > > > sincere belief that this issue is more than real, even though
> > > > > it looks
> > > > > like anticipated April 1st. Takashi can help with his expertise
> > > > > in
> > > > > clock detection and Greg could help pinpoint if this is indeed
> > > > > madness
> > > > > in the USB subsystem.
> > > > > 
> > > > > Hope you and them don't mind the escalation :)
> > > > 
> > > > Do you guys have any idea what could be possibly going on here?
> > > > There
> > > > really seems something is not right if one driver affects the
> > > > other,
> > > > especially if the devices are not actually related in any way.
> > 
> 
> I've discussed internally with Sean and Hao from MediaTek who submit
> the changes to Kernel. The original intention was to ensure
> controller's status is clean before Bluetooth driver doing firmware
> binary download when booting. However, it seems that the changes cause
> unexpected USB device enumeration problem at this timing with specific
> USB devices.
> 
> To avoid such problem, we also agree that reverting those changes would
> be a better choice. Thanks a lot.

Great, can someone please submit the reverts?

thanks,

greg k-h
