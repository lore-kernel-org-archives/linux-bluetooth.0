Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C4480335;
	Wed,  2 Sep 2026 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356948; cv=none; b=J2BkyZ7NdwvSmEFhS93aJbdTOCOV0EiKBZU6Xkr7edlcrw4UesBQmt6mttkhGu2BQ1aBhA19XGEtnh5JWo96DibqiG5ES7aNGGTggsiUUMgiFIPm+OppMNFUUkxzPCmM5IXbSTUI/1TH5lSQJW5qZ+dpYadRApe4nKBu324Ffz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356948; c=relaxed/simple;
	bh=I6IPjF4e2ZPveqeks4j7gpOuxT65brG3HWGvJFD/df8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riOslM8NYCAZSM1iIEH641Uk6z9canR9USmMZqLGD7U9Z5jjykNqNqiAUglFo89EM0uelqtQzqMlw7VwpNf+/mVXkkfnm6IPpqeTsD6pMDgyj1F3W8b6xqm9Ks9PXrBxJ2HQe5XJa/wzX7dkVFAwWmLFVbL5R8HMnN8iOvhdz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxxJkDqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxxJkDqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F161F000E9;
	Wed,  2 Sep 2026 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356946;
	bh=qREgg7CzsHv/1gfKebzVg0o4tvByFnZpDQA0xB1Irxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kxxJkDqsVkIS+ZEqmrxRxC4jGCVYhGWgb7+cJQz6s1zMjW2d9t7Wthr8R+7NCOCud
	 1UyiwVqjlKTwT0HkaUCaLQtv0VanCWQOBlYpN/j5a6Gc8dB6npMnqdEkIITZPjGlRA
	 ikGjV0fmwEe/LQ0UUnTzoRGbkisiUlpbmleteHqXX8mvLG2yuwUX5TexQ9OnwQjj6e
	 sK1iYYYaJTzj9Eyu77oK87RzXVfZlzH0omP4DfV0Ti9Vve7oo9lhDTJxGZyzcN0o4K
	 LRSjcPP/v7oYxL44nNfrQ6QSQPkLHEddA7TgVdx3p9pKRmlyfgQ01CAiaALrUF4/vg
	 HCkeCYCcBVz6g==
Date: Wed, 2 Sep 2026 15:48:51 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, loic.poulain@oss.qualcomm.com, 
	andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com, 
	cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
Message-ID: <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825092715.5794-1-wei.deng@oss.qualcomm.com>

On Tue, Aug 25, 2026 at 02:57:15PM +0530, Wei Deng wrote:
> Hi Konrad,
> 
> On Wed, 19 Aug 2026 16:24:35 +0200, Konrad Dybcio wrote:
> > On 8/19/26 4:13 PM, Wei Deng wrote:
> > > On Wed, 29 Jul 2026 08:06:54 +0530, Wei Deng wrote:
> > >> Fair point. I will move the port/endpoint anchors to monaco.dtsi in v2.
> > > 
> > > After testing v2 on qcs8300-ride-sx, BT init broke. qcs8300-ride-sx has a
> > > soldered WCN6855 and no M.2 Key E connector, but the pending series [1]
> > > uses of_graph_is_present() to detect whether an M.2 connector is present.
> > > Since of_graph_is_present() only checks for a 'port' child node, the empty
> > > anchors in monaco.dtsi caused hci_qca to incorrectly enter the M.2 pwrseq
> > > path on all monaco boards.
> > > 
> > > v3 moves the port/endpoint nodes back to monaco-evk.dts. Please review.
> > > 
> > > [1] https://lore.kernel.org/all/20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com/
> > 
> > The series should test of_graph_get_remote_endpoint() instead
> > 
> > Konrad
> 
> Hi Konrad,
> 
> Tested: replacing of_graph_is_present() with of_graph_get_remote_endpoint()
> in hci_qca.c works correctly. The M.2 pwrseq path is only entered when a
> remote-endpoint is actually populated, so boards like qcs8300-ride (soldered
> WCN6855, no M.2 connector) are no longer affected.
> 
> Hi Mani, Loic,
> 
> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
> suggested moving the port/endpoint anchor nodes to the SoC DTSI
> (monaco.dtsi) for clean DTS layering, so that board files only need to
> fill in remote-endpoint for boards that actually have an M.2 connector.
> 

This means, the dummy port/endpoint node will always be present even when the
M.2 connector is not used. I don't see a compelling reason to do so.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
