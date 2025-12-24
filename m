Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B23321DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569167; cv=none; b=D8c/coMXMEofkWHcsxHVcqHb/WZ1f2O6zFPSg+ITWVb2aVhgHcihMqv9ZzMakNClVQxvTWdDbtRfStaGrKfSB/SEHwvZ6JH0ItAwALvqwKGk8xNyLX2ZrLMsbVn5IVsgoas6PJtOzIjq0uXEFeTKjYwfUS4HeK7KVadlgjELAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569167; c=relaxed/simple;
	bh=CRmcAoyUtq6iBXHMPiagvrM09Lai/RUX2snbRGcswAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOkfSeWMDphFpG7N11m/1kj0YgD3n2yONDc7zXRPPy/H8oNcyfkRGoMJRZI+CggOxACKZw7pwGp1+iXJ31qn8e9Rs6d1chQgVarOp66Fm0li8kPaI++Ryj7BKlyBagDRa3SJZQ/xOG6vVmzq2mK0TspKeYZOIHAwKMf28V9HW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M6Jox/0T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bxojaxb5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6Jox/0T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bxojaxb5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO0Cs9e559749
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 09:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G8oSoDiKphsc2K7HPgkLLB/R2Zw9DltlgN5tqv7NL44=; b=M6Jox/0T1szsJYDX
	rlKboitPKBlYHMO36SDSTOJmXH4rn3ryrh/hs5rou/6tHky1i3feuK+SJk+B7ZO1
	WPlE33D4QW29fFeDO3dK0xs5P2s+43BTAlBpXpsYgb34R4QfTyM0RM4WDFrEEttM
	SwSugsk6AC9Ycjlpm1tY3/6yBn4ZLdpQmT8Ze3kep2w9OuN3kwMvFalzha1UyqJT
	2qtKWAF1nFT2G5OtClp1yUzc44GJefb+FK70q3qYZC8nCuSN3vTMC3uHAk4mW8Sm
	fBtFI+VHhlkzgFgI7GpQBHEhf+CzNeLTD68c/UHkWrWmw+sw1Bvg+YK9Y0FTCTYE
	NSZ+9w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7u9cu57r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 09:39:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f4a92bf359so123840791cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766569163; x=1767173963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8oSoDiKphsc2K7HPgkLLB/R2Zw9DltlgN5tqv7NL44=;
        b=Bxojaxb5Tg2LVchK1NUxf/r6X+735UHuxkeUZ4iJ0pSUQ7Rt6tKas6lcu++7twigcq
         Ko1NAJyc93RkjH73PrTHbCPQFREj313O0NVwl+j3/QbooFXsyrrKSMtttRc887CvP6c6
         HfQAS7w+ALJjdQVnl63xuIN/hrR//aGRwqGuKfKMRHy5xXNsjnBV1+/R612NNyor+eYl
         UzcT4YssCk0+xUnbI1JxDC4W+b8a2nCZo51I/0IH0sYyxPi21xQP73UAk+2pYo7Qdi8q
         zsuz4CTpE6+egJiSotnn7HL30iTX/5gtcLYy33z724jq3MQnqYWgtFj2WvPzQMgpvMmq
         nr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766569163; x=1767173963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8oSoDiKphsc2K7HPgkLLB/R2Zw9DltlgN5tqv7NL44=;
        b=ZxsiIxt5chhe5bf6pekI3R8jWjUaS2ciqQp9TGK+zBQA08qo1Ztv5dxND7BU6MIBdM
         4flwJ5RyTkSMiQP9InS6yzWSGaCEJt9Q/p6YFp8xtTN5ApNkjYO15d+GNq+2t32zlyTc
         xwko8jkCmhcHH3UEv7QSXdoAAVIIcbgfBsjlabTAID9i0S5G74wY1kk+cse5ypfEIB5/
         mBflN0VDaeDJV5rM3ZyKZMRDvPjljs9LH6wFggm+F8iS88cUJ5tGkov9vp6HV1n2903e
         dIODwaxVRTuBuxU3K/PJ4TC/Zwjpw/z7TFVUKWnf58HvuHnviUxJzPFi3JC93CbrTf7i
         6VpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjPnm8Z0FFvJEnUlLU274CqsC9DK4wAsJY5cT4LLN4XyJ7JNlkqm+MjITdQgquhr0ha57ZKKkxLOEEk0++mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmjdafltbYCfSi1Iap96KIHjvlXOFiqd2GaNGk7oHsSFmnk4q
	q9eTaTNmwjV/7DwDLkA2ZyEtkgfiTmABERxoPSZK2f9B+A7RZbSfH//hLmH293cStpl2Liga/gN
	kRX1QnG1KTaqJbOuiUIzsmJ6flwjQGck4AheWpe3G/rKkg59Q+foL7Bwvq9gOAF2Ggl/dqehy6n
	UXv1c=
X-Gm-Gg: AY/fxX4aG1Q+iDgW2N6YHqq5X5BjmvXOahusza9D/Ngz5k6GK/CLhjzm2PjDhIWX3ve
	hIX7a13Ce2o/N7GT7JoaWjolpjQKYFRrZniyI5IgAbACjdGE2se9HdY0wsRC2+iFE4f0DUarSnL
	vtLiTo+BUNWTn/u4yQmm+Fyy4b7qRQ2OQYAf3rz41NnGvvGGBz0hekXzKXTE6taG9RrTTkClWVf
	69NJFspRs+unSSLL0ulKE1QdjfwL0cQh6fbKAmaSnOgMxOJdvrszgrt7t5wl54j3Wb2fbdmbCF1
	y1ByRG1JdvYiJ34g8IdYV0G+O2GimgLkrEvQ6W59GalV9WdSUnvZsFTM2R/+RTFOiCZ2FqHah+l
	pXRGFbp32RJG4VMgyBYoTYTC4Zgf8nbmQNY8NCyMuyYhOQwhhf7eu4pPC1+cOdYZKcH0ABMvm4d
	zN0Fb3Ds9mjxO+VU80lYveL38=
X-Received: by 2002:a05:622a:a11:b0:4ee:219e:e74 with SMTP id d75a77b69052e-4f4abde4c12mr262730171cf.77.1766569163341;
        Wed, 24 Dec 2025 01:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1EkHCdKkOcBB5LGJZfj81ocGScXvaPa/FpQOuK0uf4tBOBlM/EqUQ7SnuQ5tdLmrlMnP3dQ==
X-Received: by 2002:a05:622a:a11:b0:4ee:219e:e74 with SMTP id d75a77b69052e-4f4abde4c12mr262729991cf.77.1766569162875;
        Wed, 24 Dec 2025 01:39:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812264cc13sm41134671fa.37.2025.12.24.01.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:39:22 -0800 (PST)
Date: Wed, 24 Dec 2025 11:39:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <4pfooyem3h2ljapiye5faljkwi7aekaep6z6o4jviqghu3nsdg@7tslak7jyuky>
References: <20251117021645.712753-1-shuai.zhang@oss.qualcomm.com>
 <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
 <mtp3qxngbnlpzk2cdp45ndtecab2h56ocwm6cp5ia7butra55a@bevidj6vdwzj>
 <c3526d32-6769-4681-bc54-90a4af082265@oss.qualcomm.com>
 <bvkfq2cg3nstegininpxjr2ldfv2kode3fy6ekv5vuwbh3lrv6@qnvxwsu7y4zl>
 <e9190f33-de6d-41f6-88bc-1f90513bcb3a@oss.qualcomm.com>
 <t4rfkbbw4pkio5xwar5ilytkjsfiok7ni3xbrhbhh46e557xga@m3uannuoqja4>
 <fb6d72f5-b35b-41d8-93d2-eb4fa83c513c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb6d72f5-b35b-41d8-93d2-eb4fa83c513c@oss.qualcomm.com>
X-Proofpoint-GUID: aMx7vHsAZ4NMl2qf4oyrnCIPQcijyLXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4MiBTYWx0ZWRfXyIxFR3Jci6jK
 dEGsj3s0G0kRKd3SChh0OVXr9i0F0h74++78gGACWmcd/F57JAdqCtV2IUD23M2Kdno2v6J5qPo
 5OoL4QVh9JQc8f1J0qu4gTGDGhEqR0T+RLVBDqahwV/0Qp3XCeFNLSKrnW69yomDZNCgMdY48hr
 l2v0ov62k4Hi6aPsXSeQZZKvMJ8mT4ZiQ5Z8fHnPVwLSTHX0yoMeLCxE8Cnm582+vtlToLK0GMZ
 34CzqiCuzrCQcp0Tbu0dYBNl79YAWYnuzGI+LaJuVl7Izm2LRoKPJATxwSH305c5ocK6jG1ExqG
 Od+MseikJGqajMb1jaHTJ6hDp2hVT+vi8KxjfiGc5RfwWHw0HO0K6TWvlTfTW5nRJjFFVx4s/39
 plGc/lRcYaSCiK5G/hMdDvGhQoa/E7L95bYGZQpGqqAH/a2HBinMh4G4At2W/5LfFb5Z+imaHiu
 H/XDjta8whj4iAj/09A==
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=694bb4cc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=cZbSsLDkPTXUyY1cNiAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: aMx7vHsAZ4NMl2qf4oyrnCIPQcijyLXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240082

On Wed, Dec 24, 2025 at 02:54:24PM +0800, Shuai Zhang wrote:
> 
> On 12/24/2025 12:23 PM, Dmitry Baryshkov wrote:
> > On Tue, Dec 23, 2025 at 10:03:44AM +0800, Shuai Zhang wrote:
> > > Hi Dmitry
> > > 
> > > On 12/21/2025 11:21 PM, Dmitry Baryshkov wrote:
> > > > On Fri, Dec 19, 2025 at 05:19:30PM +0800, Shuai Zhang wrote:
> > > > > Hi Dmitry
> > > > > 
> > > > > On 11/19/2025 3:59 PM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Nov 17, 2025 at 10:16:45AM +0800, Shuai Zhang wrote:
> > > > > > > Historically, WCN685x and QCA2066 shared the same firmware files.
> > > > > > > Now, changes are planned for the firmware that will make it incompatible
> > > > > > > with QCA2066, so a new firmware name is required for WCN685x.
> > > > > > > 
> > > > > > > Test Steps:
> > > > > > >     - Boot device
> > > > > > >     - Check the BTFW loading status via dmesg
> > > > > > > 
> > > > > > > Sanity pass and Test Log:
> > > > > > > QCA Downloading qca/wcnhpbftfw21.tlv
> > > > > > > Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> > > > > > > QCA Downloading qca/hpbftfw21.tlv
> > > > > > > 
> > > > > > > Signed-off-by: Shuai Zhang<shuai.zhang@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >     drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
> > > > > > >     1 file changed, 20 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > > > > > > index 7c958d606..8e0004ef7 100644
> > > > > > > --- a/drivers/bluetooth/btqca.c
> > > > > > > +++ b/drivers/bluetooth/btqca.c
> > > > > > > @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > > > >     				 "qca/msbtfw%02x.mbn", rom_ver);
> > > > > > >     			break;
> > > > > > >     		case QCA_WCN6855:
> > > > > > > +			/* Due to historical reasons, WCN685x chip has been using firmware
> > > > > > > +			 * without the "wcn" prefix. The mapping between the chip and its
> > > > > > > +			 * corresponding firmware has now been corrected.
> > > > > > > +			 */
> > > > > > >     			snprintf(config.fwname, sizeof(config.fwname),
> > > > > > > -				 "qca/hpbtfw%02x.tlv", rom_ver);
> > > > > > > +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
> > > > > > >     			break;
> > > > > > >     		case QCA_WCN7850:
> > > > > > >     			snprintf(config.fwname, sizeof(config.fwname),
> > > > > > > @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > > > >     	}
> > > > > > >     	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > > > +
> > > > > > > +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
> > > > > > > +		snprintf(config.fwname, sizeof(config.fwname),
> > > > > > > +			 "qca/hpbtfw%02x.tlv", rom_ver);
> > > > > > > +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > > > +	}
> > > > > > Is there a reason for ignoring how it was done already for other cases when
> > > > > > we need a similar fallback? Please extend the existing code (or rewrite
> > > > > > it) instead of adding a similar hook at a completely different place.
> > > > > Current Strategy (when DTS does not specify rampatch and firmware):
> > > > >       Rampatch: Load the rampatch based on soc_type.
> > > > >       NVM:  Load the NVM with board_id based on soc_type.
> > > > >                   If the file corresponding to board_id does not exist, then
> > > > > load the NVM file ending with .bin.
> > > > >       For HSP (new requirement):
> > > > >           First, load the rampatch/NVM files wcnhpbtfw and wcnhpnv.
> > > > >           If not found:
> > > > >           Rampatch: Fall back to loading the hpbtfw rampatch file.
> > > > >           NVM:  Starting from wcnhpnv.bxxx, load the NVM file ending with
> > > > > .bin.
> > > > >                       If still not found, look for hpnv.bxxx and then apply
> > > > > the above NVM strategy again (soc_type(board_id)  to .bin).
> > > > > 
> > > > > The current changes are based on the original implementation, which should
> > > > > make them the clearest modifications.
> > > > > Please review according to the existing strategy, and feel free to let me
> > > > > know if you have any questions.
> > > > qca_download_firmware() has workaround code for WCN6750, loading TLV
> > > > file if MBN is not present. It doesn't make sense to have similar
> > > > workardounds in two different places. Could you please unify code
> > > > (either by moving existing code or by moving your workaround).
> > > I tried to move the changes into |qca_download_firmware|, but it conflicts
> > > with the logic for
> > > loading the default NVM. Specifically, when there is no NVM corresponding to
> > > the board_id,
> > > it will not load the |.bin| NVM file. I’m not sure whether this limitation
> > > is within a controllable range.
> > > 
> > > https://github.com/shuaz-shuai/Add-WCN6855-firmware-priority-selection-feature
> > So, the solution is to move the quirk for WCN6750 out of
> > qca_download_firmware().
> 
> I’m not entirely clear on the rationale for removing WCN6750,
> 
> as our current discussion focuses on handling WCN6855.
> 

As I wrote earlier, code uniformity. We already have a quirk code
handling almost the same pattern as yours: load the fallback file if the
expected one is missing.

Also please fix your editor not to insert extra empty lines in your response.

> 
> If the logic for loading hpbtfw.tlv and hpnv.bxxx when wcnhpbtfw.tlv and
> wcnhpnv.bxxx
> 
> are missing is moved into qca_download_firmware(),
> 
> it won’t affect the firmware (hpbtfw.tlv). However, for NVM, if loading
> hpnv.bxxx fails,
> 
> the hpnv.bin file will also not be loaded, which is a defect.

As I wrote, you are providing more and more arguments for moving WCN6750
code from qca_download_firmware() to the caller site.

> 
> This is why I prefer retaining the V3 changes.
> 
> Please let me know if you have any concerns or questions.
> 
> > > > > > > +
> > > > > > >     	if (err < 0) {
> > > > > > >     		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> > > > > > >     		return err;
> > > > > > > @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > > > >     		case QCA_WCN6855:
> > > > > > >     			qca_read_fw_board_id(hdev, &boardid);
> > > > > > >     			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> > > > > > > -						  "hpnv", soc_type, ver, rom_ver, boardid);
> > > > > > > +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
> > > > > > >     			break;
> > > > > > >     		case QCA_WCN7850:
> > > > > > >     			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> > > > > > > @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > > > >     	}
> > > > > > >     	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > > > +
> > > > > > > +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
> > > > > > > +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> > > > > > > +					  "hpnv", soc_type, ver, rom_ver, boardid);
> > > > > > > +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > > > +	}
> > > > > > > +
> > > > > > >     	if (err < 0) {
> > > > > > >     		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> > > > > > >     		return err;
> > > > > > > -- 
> > > > > > > 2.34.1
> > > > > > > 
> > > > > Thanks,
> > > > > Shuai

-- 
With best wishes
Dmitry
