Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB532939E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550198; cv=none; b=Yli65TFPhHGRfd9I95hw6zOzN1qJDfT+MjIwPs1d/uH0H9mpz9mUxXtrap3ZiatBTFfwZTWvxFHvedKlt2iboma87Qo7N08uIgli0LPBE7vvbqdfJC1IM+4XqlYTPTTG3LiUwroKI79hcmIN7cT2xcPQ128xbAI0FthioBvzYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550198; c=relaxed/simple;
	bh=a87og0o6vdkGlqiOyeTg3QppmXyp0a6bI7G22Z6fK40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9vBrSVrIZJdUVa+I1c0FFc6aYuzS/X7GOkKojqzZUeg9PjTkFzS3pvuMPPeRYCzO8zZWcxfq87g+Liwbhvzqxm1afsauQZ7nZYgU+sK/OcFgq1WbRRwUwYH1jzjVOlvBCjHGxK7jle6LbwboDksiNsPHGbdknlT6xr4qHwXDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPeNYUrX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bm580xlK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPeNYUrX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bm580xlK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO3wmr83797283
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 04:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fq34/MnvpEDSBJilbrVWqAw7/C15pDAoEkG295AUHUU=; b=iPeNYUrXl090Yj0/
	4Sh1zjis67lFtIJbY///FHb8NsXxIe47pEELCoL6K+isQ3SOEGFF68bidl7CTTWy
	vVYJ0jU8GhUKaXecEFLE6zM+lVqouhVTqnH2T6QICftfrWtt8dGibIWaTg+pk+sM
	4BdnS+2Ei37wA9Zwr1Xv7CyhwiF5pAMDU6duAoMMCnNV4n5VQdjnOC1oM5vsW4YZ
	Rp6JBUjoHGpyjwysVm6KWNv+E/ieD8LPXpdmEmPvF0+3BUZeWaKMOEEvlv5ffZSA
	D+tdB0Eiyr68X/O4vWiXNvpLED1iOkJ2aK369h2Oyu/JR/QBrraZym6dMGWRoPow
	FSMOLw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b88r681kj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 04:23:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a366fa140so261788746d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766550194; x=1767154994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fq34/MnvpEDSBJilbrVWqAw7/C15pDAoEkG295AUHUU=;
        b=bm580xlKcbOV3X7MjB0fjL9D/kKwZxNlTBpwUTRi0nCGiuSSe5LyhaNn6RO6z4x5V1
         9g0I+WSJTVrKxd5pbQDSDqgSEdwv6xYIJ5axv4wq/rGqO9i5LZI40NpVqh3TvWkBJiQc
         SL1wM3tlc75zfKLXvn5dghUaIrHHHQEJKaskZvYwZT+84zL5R0cs7G9U6uauZPAijvg5
         NVo9hAZeaQ6yt6NSat2fi48kFPjbNCSKXu8m662q/x+G8Ie8Q2FhoxNl844y6RMnhQIl
         gPkuv0HdudG94CHRe1USYLa0MeyzuZsqA5AKHsPsx4qMM5TlOCJpat6OjQcC0x2OJ9rX
         LDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550194; x=1767154994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq34/MnvpEDSBJilbrVWqAw7/C15pDAoEkG295AUHUU=;
        b=ba5gTmKJo3H/Q868u0xPEZ1gLrMQVHXQ+AJ5JNCOFdThda8nrMSZvf69jIKbaMABX/
         C+t1QFukdZ8z83O/dne3zFPASD0wcendYfMTeFJNDPvgDtbE5YSC2m++VXjZid1UrLmw
         sburGb4FdzKiFogiNTYBPdv4QmoQIiMbYXjPWoLtPuBtm3WHRdd1+Udp9dLSn8Q2KBmw
         lmjSkH/1BcaKMjhOmb12gckXl/UUyeQhm5DfcI6rMArDRZjOtizQDsw6qMTGQdQWGr0n
         hRzUC5HGZwDR3m7C7OvVfQfAwDNeK2N1Y9lflcWFGZBekBXfqxrnuO4N6LaSaautp6hu
         eoGg==
X-Forwarded-Encrypted: i=1; AJvYcCWTE11ZtxI5QUcyyYrpzcwwuLLHnWKb1FSX+QLqoAQmUh5i12NXVxLYxwHY4urjG1ze3+qRwh2DBGy0KPNRFrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywid3PDFMPzLrgIAqPaw4jFE5VJ5Wg6uU2CCAOTxxJso08blYY6
	eZmvWtBhyzcmfSHAh9xf063RfyLy4p2/r2DW6Pnq30DdQ1w6KX6os1NBt1cz7WFfxqH5KI2nqq5
	kagpCsQuFeANfeBNc9l7rWDrXud2zw9yGL/jL7tBVR0rb2NHnx+rPz6NaLYKf5qHdgzNogeo=
X-Gm-Gg: AY/fxX7eaxu93kwRbBsNacboyvOJf28tE/v5giFYFjHqbyFBdeffcVcxh6ZMt8mrH4h
	uPbzv0eorQyilbZB+6iq6HYxnlCKU8S+Ok2NJGLtm8IrWflDPh/8XS8yX/OzrPIRezIltR1pPWS
	HzoMFT+DrSZoxWscUT1EVSu4eE3jnV7Va/AEPq/deSClpg/NTWZUlQ7JomGH4l1XP9YJ1ZB9Kik
	P1qWApTrlIJZeZSHF8CNqa3TS8RSRVp4mrkQyTHZKJaqYUcMDAl+z6JJL0h+ek3SDNs6ZS/5RIi
	8itYx726ZDo2JV0A2gyCZ4Q2I3syR1ZItfZ8PvwPGbeFeZxQXlFw0ENGzeUKh6Jk8TjRx13kIyq
	u7WDTIpGGf0tBx99whX++q8BcgQb9OtpbQ/v4CRTAIlCHKywO5u9Gbw+DJY5GnjeoKrzSlKYVal
	W6sd/K8ha/JK4HxhDxPhzqEpc=
X-Received: by 2002:a05:6214:2308:b0:87c:836:8f21 with SMTP id 6a1803df08f44-88d81f47acdmr303056946d6.21.1766550193647;
        Tue, 23 Dec 2025 20:23:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbD5hP5gLy1o7VYMjk79g2knFD2g1/yz8FId5VP1L1y8WaIoyf/EKjXtI0S5sRb9qInyPW6Q==
X-Received: by 2002:a05:6214:2308:b0:87c:836:8f21 with SMTP id 6a1803df08f44-88d81f47acdmr303056836d6.21.1766550193218;
        Tue, 23 Dec 2025 20:23:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38122501558sm39511741fa.13.2025.12.23.20.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:23:12 -0800 (PST)
Date: Wed, 24 Dec 2025 06:23:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <t4rfkbbw4pkio5xwar5ilytkjsfiok7ni3xbrhbhh46e557xga@m3uannuoqja4>
References: <20251117021645.712753-1-shuai.zhang@oss.qualcomm.com>
 <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
 <mtp3qxngbnlpzk2cdp45ndtecab2h56ocwm6cp5ia7butra55a@bevidj6vdwzj>
 <c3526d32-6769-4681-bc54-90a4af082265@oss.qualcomm.com>
 <bvkfq2cg3nstegininpxjr2ldfv2kode3fy6ekv5vuwbh3lrv6@qnvxwsu7y4zl>
 <e9190f33-de6d-41f6-88bc-1f90513bcb3a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9190f33-de6d-41f6-88bc-1f90513bcb3a@oss.qualcomm.com>
X-Proofpoint-GUID: jH0k_0m9MM4fsyy481bM_GQBB3kGyMSq
X-Proofpoint-ORIG-GUID: jH0k_0m9MM4fsyy481bM_GQBB3kGyMSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDAzMiBTYWx0ZWRfX1GXWXXBhyKVU
 MsLtBI8aeeSUSSf7mxo1OFptQ8OetFDmZAMJmLaKIxgeUvdRj6An2iHJdOmyOiDv6TTl0rL/EFE
 5OnRcxS87JBMHlcUQY9HCvZHxTEgXPF7TDA0hbjIXG42sDg3B/hGW16B5MvSNPpDCMdL3DtUUWf
 /ISD1oelv0Sa9iKVQTBCs3/ksRAiX7d9+U988tZL/OqT5tOX0aMjbmIPqo1K1U5pdkl/3NHIkCD
 nHuX2B1TbOSxoHoy/QYSY2v46Rgc9dRqXcqNIVV6mZto2Rd5Xh0dZGCCk4HCBa1QT0KG1AHXMWb
 8b/Jt+InkH3SnksmhZtDG7kw8AGkY3rsYBuCIMM9Lp3eZwmKlYsCJSyAPYKTVrnw08CzaX9j+fd
 AQlUuFWpFbyRr+VO2zClydCY4fyDfX2FGi6fWYF6oBHjNgfTjz7dvsnmst/p3dFfjuygw+69B2Z
 rlWjGqLUJRWtF4waz2g==
X-Authority-Analysis: v=2.4 cv=Qahrf8bv c=1 sm=1 tr=0 ts=694b6ab2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=f2XmiOMSutfLZ9nrRj8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240032

On Tue, Dec 23, 2025 at 10:03:44AM +0800, Shuai Zhang wrote:
> Hi Dmitry
> 
> On 12/21/2025 11:21 PM, Dmitry Baryshkov wrote:
> > On Fri, Dec 19, 2025 at 05:19:30PM +0800, Shuai Zhang wrote:
> > > Hi Dmitry
> > > 
> > > On 11/19/2025 3:59 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Nov 17, 2025 at 10:16:45AM +0800, Shuai Zhang wrote:
> > > > > Historically, WCN685x and QCA2066 shared the same firmware files.
> > > > > Now, changes are planned for the firmware that will make it incompatible
> > > > > with QCA2066, so a new firmware name is required for WCN685x.
> > > > > 
> > > > > Test Steps:
> > > > >    - Boot device
> > > > >    - Check the BTFW loading status via dmesg
> > > > > 
> > > > > Sanity pass and Test Log:
> > > > > QCA Downloading qca/wcnhpbftfw21.tlv
> > > > > Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> > > > > QCA Downloading qca/hpbftfw21.tlv
> > > > > 
> > > > > Signed-off-by: Shuai Zhang<shuai.zhang@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
> > > > >    1 file changed, 20 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > > > > index 7c958d606..8e0004ef7 100644
> > > > > --- a/drivers/bluetooth/btqca.c
> > > > > +++ b/drivers/bluetooth/btqca.c
> > > > > @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > >    				 "qca/msbtfw%02x.mbn", rom_ver);
> > > > >    			break;
> > > > >    		case QCA_WCN6855:
> > > > > +			/* Due to historical reasons, WCN685x chip has been using firmware
> > > > > +			 * without the "wcn" prefix. The mapping between the chip and its
> > > > > +			 * corresponding firmware has now been corrected.
> > > > > +			 */
> > > > >    			snprintf(config.fwname, sizeof(config.fwname),
> > > > > -				 "qca/hpbtfw%02x.tlv", rom_ver);
> > > > > +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
> > > > >    			break;
> > > > >    		case QCA_WCN7850:
> > > > >    			snprintf(config.fwname, sizeof(config.fwname),
> > > > > @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > >    	}
> > > > >    	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > +
> > > > > +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
> > > > > +		snprintf(config.fwname, sizeof(config.fwname),
> > > > > +			 "qca/hpbtfw%02x.tlv", rom_ver);
> > > > > +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > +	}
> > > > Is there a reason for ignoring how it was done already for other cases when
> > > > we need a similar fallback? Please extend the existing code (or rewrite
> > > > it) instead of adding a similar hook at a completely different place.
> > > Current Strategy (when DTS does not specify rampatch and firmware):
> > >      Rampatch: Load the rampatch based on soc_type.
> > >      NVM:  Load the NVM with board_id based on soc_type.
> > >                  If the file corresponding to board_id does not exist, then
> > > load the NVM file ending with .bin.
> > >      For HSP (new requirement):
> > >          First, load the rampatch/NVM files wcnhpbtfw and wcnhpnv.
> > >          If not found:
> > >          Rampatch: Fall back to loading the hpbtfw rampatch file.
> > >          NVM:  Starting from wcnhpnv.bxxx, load the NVM file ending with
> > > .bin.
> > >                      If still not found, look for hpnv.bxxx and then apply
> > > the above NVM strategy again (soc_type(board_id)  to .bin).
> > > 
> > > The current changes are based on the original implementation, which should
> > > make them the clearest modifications.
> > > Please review according to the existing strategy, and feel free to let me
> > > know if you have any questions.
> > qca_download_firmware() has workaround code for WCN6750, loading TLV
> > file if MBN is not present. It doesn't make sense to have similar
> > workardounds in two different places. Could you please unify code
> > (either by moving existing code or by moving your workaround).
> I tried to move the changes into |qca_download_firmware|, but it conflicts
> with the logic for
> loading the default NVM. Specifically, when there is no NVM corresponding to
> the board_id,
> it will not load the |.bin| NVM file. I’m not sure whether this limitation
> is within a controllable range.
> 
> https://github.com/shuaz-shuai/Add-WCN6855-firmware-priority-selection-feature

So, the solution is to move the quirk for WCN6750 out of
qca_download_firmware().

> 
> > > > > +
> > > > >    	if (err < 0) {
> > > > >    		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> > > > >    		return err;
> > > > > @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > >    		case QCA_WCN6855:
> > > > >    			qca_read_fw_board_id(hdev, &boardid);
> > > > >    			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> > > > > -						  "hpnv", soc_type, ver, rom_ver, boardid);
> > > > > +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
> > > > >    			break;
> > > > >    		case QCA_WCN7850:
> > > > >    			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> > > > > @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > > >    	}
> > > > >    	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > +
> > > > > +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
> > > > > +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> > > > > +					  "hpnv", soc_type, ver, rom_ver, boardid);
> > > > > +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> > > > > +	}
> > > > > +
> > > > >    	if (err < 0) {
> > > > >    		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> > > > >    		return err;
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > Thanks,
> > > Shuai

-- 
With best wishes
Dmitry
