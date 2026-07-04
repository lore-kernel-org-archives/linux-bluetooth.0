Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704F42048
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783123885; cv=none; b=D5IR61iWxxEYjmhGEgbqsfunILogESVMLXdDD8HSFV1xjGOfwxqNJ8U5BkHhFtsbvMj0GXgWWXEgvttYp9/nRgQVIpBBXbIAfhtaFG6WuBelEP97nQLYgPbGWLkP/mJr8jBW1rz5L/wsczJtZ1CuyORNWRJzDfXanp+h4sj6ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783123885; c=relaxed/simple;
	bh=EFAk6omUFHjXLhMkrfuSYGKNX01S2aDtdDFlhsFz0BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqZoc2blxcqiuVab2EYqPy2S7AGftktXjEKti6Lqaylf/Ueg6+Mco17lm/4cevPvGOhiSkyFHTfgZ1KIQnrwAXvfydQXjnoxOzixsbXu5+NZJs8qxE58/X2NASRgtPRmjZd5zWFoATv6i4daSkTaFw9P5EuigDRmPTLt/HrH7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqH/gDDg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CsMR5P8g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqH/gDDg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsMR5P8g"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPZZH1029410
	for <linux-bluetooth@vger.kernel.org>; Sat, 4 Jul 2026 00:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SS9o9JjJa9J8UmJUhMCdC3pi
	ejIqkiHZHZsGM8TZo4I=; b=jqH/gDDgQpSmr0oiD7c2B7+Uy/u2O2xzv1nDwpCb
	u/muolKwjlloLviJwSabzZkVEbbNbPCFvkXNCtpIn5kvtOI7352zMtt/Y9veMXp3
	EanpFIr47wfSD64Kn5k1RoFrMe41SqBclav/V7v/VKtkxIajCg634wltUnAZLOBA
	JlB3gGld8AWZGaQtX/eUd9U46dDHBgNDruWhnXh/hcDI/lq6MT+C6RY54HGSIBCq
	zOKeIUbSht+CGJ4SzzgSpwepcvLnjUpgSCSgGBxqOqbxFDz8ZLCsrP5u1f6KEDlG
	z3CDSefoiJJZF8QjXDgerPmnLl9RMd47IQ3EXrwthch7ww==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcm1mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jul 2026 00:11:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1b4d961dso9291161cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783123879; x=1783728679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SS9o9JjJa9J8UmJUhMCdC3piejIqkiHZHZsGM8TZo4I=;
        b=CsMR5P8gy53vwTnWTTETcFSxzb6tCzdEHyCIvxaH6bfvqwOoJaLvR7FgthR8wlzYKd
         im1na3qnqcbolD5WowtpuYT+BKfpIfPIxMGEzcFYFeaUWpUQae3td/Jg5IAAn0GEzwrq
         X459DWAGFIAxCUK0beLd++UbQtL3kdYf0ANlE2lpdpPQHI8Vjb6WYoRktqGrqeVT5DMS
         3VFmxhqbl9UwD79ovzNJdSW/G5qvtMtgZzovLC6vbzs4w4avlFmIjxIvNR7LLmVCAhdQ
         1XO7jqC2N4TgjTWapqTuOBXz8IApUz9NNZZG4o/e/MhtW3NVYjsDBhr2LIz0r9+9Neh8
         LJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783123879; x=1783728679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS9o9JjJa9J8UmJUhMCdC3piejIqkiHZHZsGM8TZo4I=;
        b=D+vb23euhS1kIXOQcOKSwLDvkrnyAogJF2/8QwOAtrXIPZWpuVAdt1KSrZyD6i/yPt
         hbeWn0ELhLYf1/C6oTCIaiiv9BiavcYqcm12aahBoounkngpXW/3xzKWozCU6JzTSxrX
         WghqRlQUn9UrtBGrpcwCedbKewaafVJuRaQi8ksKIoQsD2S5siwxG3LSnBJD/uQyl2OK
         IDSio4COhaOk+ls+WIjoeVukfCzHa2Nb3Tv8qGXzwsCnk0Kn85IYnc4AFQkqTcx/OkBK
         mpREWbs/GuA9EaS848GjA2G8GFy+fInDtCGFf+Q2PQp1/qsQA3L8oYLfrueB2BdFMf2i
         0zbA==
X-Forwarded-Encrypted: i=1; AFNElJ8Q/ReEs49jXq+CiINczIjF4vs+Zw9oKF4McIQDYTGk9wIxVWQpu4ss6Stqtz0RkCOmT71o6YZrdnUaxNUz1dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUhTQCFmiXfFXxUC9IKlMW7eGvxe9Gj5GDkir2Kj6w8mc6hQ8
	GgF43oOZgvPm7AnJ0fHcDKO06S7nb/nhgZ6a0wZgBTdLVKM+zc7miUt+CELmwZnxqAw//3K6Gd+
	q7lBfNhEyjrhca0YXexYXymr/XALu+0TJGmx614cMHVjKmPi70ArW0gnGm5iPK8+6mBTM1C0=
X-Gm-Gg: AfdE7cnPIJyOjaiikR7mgK5a5OTUIOFmnZTctWfRZ1IN3e0exOQ3NxHwI2vEYNueQzv
	6CHkKYIvDlYQKKwP09Kfx58Du9ubK5kM3TR/t+mM7doC5GWduaAuPiugaLTb4DDDvZ4+gJHwfe+
	k6ZRt0O/L+p8uXRZX7ImLsbFPxf9eRnZeCqoQQf7NSJXtbIcAoGlo+5Xmz2/bRdWkrCXN4ARUqH
	gbDf1jL9WoCzPPJo63e9I1VG4AcDHl/Mxv5j32AFLe0Pyvd1roy4vYtzI169vLG0XDD00YPpnSd
	lDJRpWIB/PRYACC17YLTNaNNFGdlCLF5Fu2hT/HyC5ewTvBoNqt03Q3t96vCPBZstlpAcZjb/85
	1dfDuyRnU6NFGQCt8wSWq5GmLex3CZNMSl7ZarA+xCzRztykyFzUNLWWTTLxsibIdom+rNosJoW
	ZbE6cwaEQMj8xJwV9LwNqLAjGj
X-Received: by 2002:ac8:58d0:0:b0:517:f9cc:1fb2 with SMTP id d75a77b69052e-51c4d14ac8fmr17562771cf.19.1783123878998;
        Fri, 03 Jul 2026 17:11:18 -0700 (PDT)
X-Received: by 2002:ac8:58d0:0:b0:517:f9cc:1fb2 with SMTP id d75a77b69052e-51c4d14ac8fmr17562351cf.19.1783123878517;
        Fri, 03 Jul 2026 17:11:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b4ad39f41sm5309571fa.15.2026.07.03.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 17:11:16 -0700 (PDT)
Date: Sat, 4 Jul 2026 03:11:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <ynhos7h4x3kbqbio2gkigoo5rqbwogrzihkylxv5pqjtqpqmnq@rlyjaiopx74a>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
 <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
 <rxt4n6vuscu33mrw24af72lb3s6urqfpkhtia44yfo4j7wtu6o@3xp57owekrgj>
 <u5ieok3hgjcf74sxjdzv6xurmlbve46xa3imgfnom4hpjarmxa@fna5daqpyk3r>
 <zat6uuvh7jwfxajvqtif6d67osf6h5b2vxig3bmuch76btpdkj@bfxjj7kk5fjk>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zat6uuvh7jwfxajvqtif6d67osf6h5b2vxig3bmuch76btpdkj@bfxjj7kk5fjk>
X-Proofpoint-GUID: 0WWu1-ox2cI90WMZ2Lw2UVyMGlX8W2oq
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a484fa7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ngL9UUSe-LbVx-9XVVoA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 0WWu1-ox2cI90WMZ2Lw2UVyMGlX8W2oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDI0NCBTYWx0ZWRfX8IolNphqLVXn
 lidvi6U25UIDEkFB2AY2wIKSwPx03kxKclwnUUNJqyFOBrZVVhUg86jdW5KOKOgG5veqc3sjwZU
 ZP2GvyJkSkSRlM+mzGZNPVMVhPZTxYHpbVVOZqExsH+3fgdLkmY3okg8yVcv4Ce/GFMfQqRtZhq
 R80AsZR6w2lSLRbqKkzlQge4fb857CUGLe6yf6KmOi4yt+ybsQQrLJUaUM2M2WxVca0ZStRDPyA
 0aDTEgF+bYIWh6zul4wj8/A9ocfPylc//R3QsouxvPm8KzhfkN9ZWMoeWr3d7vK7vz/fAu2dLPn
 3XIJvUjfGI06/eJ5/jNapsHi54F/qaLjWqfcg4jGrUlkQ3UbFmtuXzzrK60s6BfXUVjD/RjNcTA
 OVqCJAHEZGJnToNIkYBjU0Hf1qr1BlsViXVHrv7l5YdtvrSfWx5k372hVBtswinqXThMkl4Mrh8
 h278cshMQYhIxl7CiBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDI0NCBTYWx0ZWRfX7+mJOwz2R+OK
 xjYaEiJVbUt5sZUT5elsgQTAZQC8CNz8zCW4TZ5PnyRX8SOSw0OEkN2WjXsFBrqZBzTR1/M8ePl
 P1BonbFQQXNV1AbOQ8CXM/BtBEwxjOY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030244

On Thu, Jul 02, 2026 at 05:08:56PM +0200, Manivannan Sadhasivam wrote:
> On Thu, Jul 02, 2026 at 05:34:31PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jul 02, 2026 at 04:17:43PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 02, 2026 at 03:14:49PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> > > > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > > > > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > > > > sequencer rather than a dedicated BT enable GPIO.
> > > > > 
> > > > > When the serdev controller has an OF graph (indicating it is connected
> > > > > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > > > > connector's power sequencer and use it to control BT power instead of
> > > > > the bt-enable GPIO.
> > > > > 
> > > > > Also allocate bt_power unconditionally for all SOC types since the
> > > > 
> > > > Can we just fold it into the main struct?
> > > > 
> > > > > pwrseq path is independent of the SOC type switch.
> > > > > 
> > > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
> > > > >  1 file changed, 43 insertions(+), 38 deletions(-)
> > > > > @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +/*
> > > > > + * Acquire the M.2 connector power sequencer.
> > > > > + *
> > > > > + * An OF graph link on the serdev controller is only present when the BT
> > > > > + * device is attached through an M.2 Key E connector. In that case the UART
> > > > > + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
> > > > > + * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
> > > > > + *
> > > > > + * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
> > > > > + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
> > > > > + */
> > > > > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
> > > > > +{
> > > > > +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> > > > > +	struct device *dev;
> > > > > +
> > > > > +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > > > > +		return 0;
> > > > > +
> > > > > +	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> > > > > +	if (IS_ERR(qcadev->bt_power->pwrseq))
> > > > > +		return PTR_ERR(qcadev->bt_power->pwrseq);
> > > > > +
> > > > > +	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> > > > > +	*bt_en_available = device_property_present(dev, "w-disable2-gpios");
> > > > 
> > > > I think here you are looking into the exact details of the other of the
> > > > graph. There might be other devices on that side, while the code now
> > > > assumes M.2. Or, consider having an M.2 controller which handles
> > > > W_DISABLE2# internally rather than through the GPIO.
> > > > 
> > > 
> > > This code only deals with M.2 connector in specific, so I'm not sure why we need
> > > to worry about *other* kind of devices. Let's worry about them when they show up
> > > (with graph interface ofc).
> > 
> > I don't think we want to go through the drivers using M.2 connectors in
> > such a case. In the end, the contract should be that there is a power
> > sequencer on the other side of the graph, but the specifics of the
> > connector should be abstracted out. Do you know, if in the x86 world the
> > W_DISABLE2# is a GPIO or is controleed by the hub.
> > 
> 
> I tried to abstract out, but Bartosz didn't want pwrctrl APIs to do that level
> of abstraction as pwrctrl APIs should be generic and should not be bind to a
> specific connector and exposing its internals.
> 
> That's why we ended up having pwrctrl core exposing the 'struct dev' using
> pwrseq_to_device() and letting the consumer extracting whatever information it
> needs.

Do we have other ways to control M.2? For example on the x86 systems,
are those signals controlled via GPIOs (or GPIO-like registers) or are
they controlled separately by something like M.2 controller? Or do you
have an idea about other non-x86 systems?


-- 
With best wishes
Dmitry
