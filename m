Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016803;
	b=WCeSFthgHPCFAT/74tw4SI7hL46Q4bGRHiqM4v97VavUsfdRUFjE0rLC+DwxOA/f6DW6
	 Hl6sbbor9o9Idk6cD/xeNx3cN2w+OKiPdyJjte0b5+ZQOeWoYva+bjGkyAQHLKjkJcOEi
	 S4OjvGLOjIfL9MySFhKNU9CROE+PHCxAtqPeFQ5L0RE873JBhJRR4X3S0+TnsSP2tI0oh
	 hhg6SpwoLrrrP5A83RtYKqwQe9+P+Q8i1BnQTZOu9ax8oRqRJpVht93hkhmznm9rzfo8L
	 U8RwotaZpA8pnDsJk0wyZOHHkszPejFx3mW8KKqS5ghrW3vt0lqjreDKLq8XbQPmdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5kpg6tu3jJ87t2WAsg/Cx15iwbLBaiT8eGmLfTt2JdM=;
	b=q/VYhVm0JvwXwvYh22LZzlsiBxrKbOT/Jxds+dRnVANW09iWPqD9/PbxJkJ/UKMXobNC
	 Vi7UCBAXXbwBZ40oxtByGSf7EQjXUd0ug07vNiQ2ZOFsgVS/c4XBzjhWJ6dgKjTHVX43B
	 zowOPdC4cAAQICsVW7xxHqmL3kld2yA1q1h9WSuXQZBz8628k8EJ7Ka/zEYxuwKRcYn64
	 NIGkV+z+SAFCr2aBI0jHIgiPs1Z/IdpZ7yRtoMwu17xfYZ3Aj5fgvMonslCkGM16QTZbQ
	 8ZeOVH/Xh+UBF4p47OPBldbUg38nz54IBh4xnwNEKGHoiSkO32r0+mFHHYnTqN6shVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrrh1Cnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D13606A31F;
	Mon, 26 Oct 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrrh1Cnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519AC1F01828;
	Mon, 26 Oct 2026 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016802;
	bh=5kpg6tu3jJ87t2WAsg/Cx15iwbLBaiT8eGmLfTt2JdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zrrh1Cnkh1X9Zp52CwB31ogBR+JH0zOj1Dqf6y0qLMU28HWa0BU0nc9Hh7DR6xWLZ
	 mdIGGyALyrVrAOhiP/QU5RHrankJTrUEZ+xN+cOaf6oKSvFVjxff0ZkBw3xVWij9L8
	 ZoEbAJivrJo0FACBLttHT3OC0nJG36nL2m3sRfcwuQncjpXm84IRenPRlHGzqMMcOi
	 fmdIVeyKdW/hAX5aIZqzjMrIG4+ubepfKK7UjGi1liYiXPVfrH4BZA/h3iy7hSG1hj
	 fuJoKeYCWZyP/I0m7DTt1vU9JS92rVcCMOX0pbJjWPTZ/ZcyofUhwefzgc3bQsTOVJ
	 T+1/3eb1aFyyQ==
Date: Mon, 26 Oct 2026 17:43:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
Message-ID: <at9Dn2N-PmLOPaeq@debian>
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com>
 <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
 <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com>
 <CAFEp6-2KDxDrfTZLN7KPRg=aavj8nqQr7ftna23n9C1Cpbwwbg@mail.gmail.com>
 <e26f0360-aaed-4e40-b1b2-956c92d34db5@oss.qualcomm.com>
 <CAFEp6-0b15kV6ehMN4Pv24UmMo7xFYr=H396dvdD1Teh7h+K+w@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-0b15kV6ehMN4Pv24UmMo7xFYr=H396dvdD1Teh7h+K+w@mail.gmail.com>

On Thu, Oct 22, 2026 at 03:08:44PM +0200, Loic Poulain wrote:
> On Thu, Oct 22, 2026 at 11:34 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
> >
> > On 10/13/26 10:13 AM, Loic Poulain wrote:
> > > Hi Folks,
> > >
> > > On Mon, Sep 21, 2026 at 2:38 PM Konrad Dybcio
> > > <konrad.dybcio@oss.qualcomm.com> wrote:
> >
> > [...]
> >
> > >>>> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
> > >>>> suggested moving the port/endpoint anchor nodes to the SoC DTSI
> > >>>> (monaco.dtsi) for clean DTS layering, so that board files only need to
> > >>>> fill in remote-endpoint for boards that actually have an M.2 connector.
> > >>>>
> > >>>
> > >>> This means, the dummy port/endpoint node will always be present even when the
> > >>> M.2 connector is not used. I don't see a compelling reason to do so.
> > >>
> > >> I don't really see a compelling reason to defer re-defining them to each
> > >> device DT either..
> > >
> > > Adding an empty port/endpoint at the SoC level is problematic for
> > > uart, port is not always expected, this depends if the uart is exposed
> > > through a connector or to an onboard device. So we may end with an
> > > unconnected endpoint but still have a bluetooth subnode, which can be
> > > a bit confusing... Also why adding a port/endpoint only for a specific
> > > uart in the dts, and not for the others? This is a board/SoC level
> > > choice to use a specific uart for M2 or not.
> >
> > From my perspective it's removing boilerplate. Currently all USB and
> > PCIe hosts already define their ports and endpoints in the SoC DTSI
> > and if they're unconnected, then simply nothing happens.
> >
> > Both 'ports' and 'endpoints' are an abstract property that signify
> > 'X can be related to Y' and I don't see how that's a problem here given
> > UART is very much expected to be connected "somewhere" (with the
> > "somewhere" perhaps being external/a pin header)
> 
> Yes, but in the UART case, where the connection can be represented in
> different ways, we can end up with devices being described as both
> unconnected (no remote endpoint) and connected (via a child device).
> We can probably live with that, but if we go in this direction, we
> should consider adding a port/endpoint definition for every UART
> instance in the DTSI for consistency. The same would apply to I2C once
> endpoint support is available there as well.
> 

Yeah, that's also one of the thing I really hate. For getting rid of
boilerplate, we will be just introducing dead nodes :/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
