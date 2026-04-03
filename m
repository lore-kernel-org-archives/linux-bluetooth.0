Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A43845BD
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206602; cv=none; b=RCjOxMHcV5MYkTU/dxFPlbVHrmFCBFaH6SkdXxx3gULVk6TmzaGUVyT4k4wXeNHvOAuj5GwvmpDhhiTO0ulwBtkWvT/20p8eyBwBP13DCW89HtMrHOU6KVja9d5rsisrIObZIBkPbpKYaxf1a17xolzV8+smLKtYMsT0zH1aMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206602; c=relaxed/simple;
	bh=1eUJeYG0CVB+h6Yf3pErieNNFEG42C60JJADElcMeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb294Rv0jeg3wGDHrEY4ODXjagSsKaHDA/bSSTsT5oOvUsXOn/NBcFNRDhAyqXd2t4qZB2NPUhUck5ezLlZ1mtggLtzqjPwfJJ9KhuYutUh6fUvRhrtHF74vvKb5qAfdVYZAHagXZjN6BDqtqTJayWHjKX8wzkvLuDI827LjveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=ireZ3pbk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="ireZ3pbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206595; x=1775811395; i=martinbts@gmx.net;
	bh=MDk0CEx99dnMaEwnBFA/ZNjp/u2aD5G4Bi9vq2Zf+u4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ireZ3pbkO3fg/6BfDBK2uA5/WY0lNSh/LatIEw5K5l8/ESpkHJaTTT0WjLglfjpi
	 0IywBacIcIWOUM0BavC5Ig9O0bma1wAMn+JOjMTPIkj1/m6wz7oplpzB8yoe1gzt1
	 9C7gyiiNdpHlDn2O82eltML3loFYogAHV/EC4Wcog6yWsEmTcSWgOvj69BvDdM8D9
	 3vDizLB1Cmm9P7catMZTXI7EJtIT8BIoQSnLDNm1cEGL0koFfpbJj4mb7vYYSFToZ
	 IhZ8+kYuAa47p9zYd8zSuzw1PFQkTD2DwqXS8Rb95gGY4fWshHa2QepkC/c/3HRsx
	 MYY4OFG3QelNf/m8zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1viOKr3bLj-00kTDP; Fri, 03
 Apr 2026 10:56:34 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 4/6] dbus-common: Add Gaming appearance class (0x2a)
Date: Fri,  3 Apr 2026 10:55:51 +0200
Message-ID: <20260403085555.23871-5-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403085555.23871-1-martinbts@gmx.net>
References: <20260403085555.23871-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kjpJ9LBBSnT9Dozs1oB6SJDMpZw/CJSBYw7Hm4yCkWq8MFkia3H
 KlLxgGoLF0GndyOSepYimzleHHDM7gdpCwpfcZIGU5BpbdlfGe6MObIUBkj96/eBeqoh+Nk
 MnlhkBpx6CabpTRDG82Sx3/5vn0B3aRya14Zzj3rd6I7+0f2wewx7Q2E+aZPK06WcPw6rY7
 I55i9MP4O1MOCXdTmmYIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7sCyCLtqm+0=;sbpFNPhVDCdAxIJAsBPMs+VeiE3
 +PSp5wpRTD6CEgAP+cTJftkvRqYpZOwbHeFzb5QejMfxHlK2RQid1ur4RsPja+3VeW0MOHrfE
 VX8qlwbtCo2dYFlcnfzoxP9dqAaqSQHWJR+LQoqUWcWuluf4YY286lpivimQgGfJWpeByQNkA
 Mn6rtSc16D1EqD2psg9FUiCjDnDIytmdwFy1HpHPAJH8eA1zfF9iJIyi8Zi0iLdCN1fPNME37
 kKkDeoTuQNgP/E73CxHUN2PVjgp3I2apa/uL40obbvTW+rPmuDSMt1iYOAR2fKDNnUc1Ckhr/
 mE/raugG3SrEzxcZfQTnzDDdW/fDEpQwBx5k1peGZXAG8pis3sanofRiGaQ0xzZEKrb9+rWTM
 mqrbgLk5zNFe9rrY6i7sMlHAQBRvrrNM6+k+ccO5H/gCsFZe1rijl7oVQr/Wqys8yMJey1C9R
 tdgrCtQajh2lqS7bMyEG878X2h2uoKUa1qnd8+TkebbGzvkgnuwWjHTt8Dd7J+/LCsFvgvtWN
 Kg2YWplVP3t1sCjz230RQY3Py6qwk3xhrKd7OLDFcD2aM65qmNh/eKP2K5Pal5W8avwo8+AZ9
 q0OGECJ0xUiq6N0l7Ghn3Bq+052y3s079f5orOQXuJrqXaSRo+WSuLhzD9iX54/gsj5JiDMzC
 GjgtMsa1O80MndyT0/qgfKDRNVDRqxBGn94rTRNHE0qSro11I1rsrOvVUtWzro4l4oWMLHshQ
 XCtqXCuxsclmnPXHxVmYCo7yqoom08hkvZfBZ0YasUfdWmuUC+JcLah5F59/lPTd5zqLSp2pn
 2BJukImIimX6JQDL1LR/d9lfoHiNIeHr8hLIRuf3ICI76gky7rHsBoYHwSHl+67T23ddMIK5M
 zi9tRtBYsLmPI14tWzvZj1PtI9IrKzrkWj+0coKyQX6qkrIU7i1ZRVDf7BY2Y1HeKZOuu6kRE
 +Er/TLoMUWOipApqA1ewATDtBM8Xua4q/EB1GUFKpeu7yGE5QkTlVyDhKIdlXfP8ImsuKFZFJ
 PmL3N5f4CqKd+b6z8l1cFTNrAKicP50jSa8iHbw+JlDkoX+DSNx/JAy3FVyRhosMmojTkwr+A
 9Cr+jsxs/BMXZYtywi+WCM1wyEogE/I88a5Os2LA94D7vgQ1bf2/ohxhGKDvnjQ2/O3D7LhiK
 gO4ClNfeVB50kjSox9IGjqV4sk2vCe53tf1EL/7zs3eekMP2s15zbFWh19ZF/jcxCCsYXP61r
 wJTh9FAEPuCgmI3jgtkroMzKkWpU66a2PuCJHav9oj04bnVtHk5MTzd7VFtiKkMKl4LNlM6ER
 C9SQLbFJg+yJ7o+Sq5ZCm2vKP7HsGDR/t+T2aLRYVlaiINjOdNLwxNKVvTIB6RjVwTqBUfCDV
 khAu66rfvFyeKCUek49k1XqheWEuIWuQPWJucuD9UW7lSUqqNzZI4SXgKfIAAQHLJtqrnqMcJ
 2+jmJ48ab97sI3A2xhkIGUTrv7AVa6lVanqI5EDI7opMZY4yPRkBOr60Kmpi3IlHEpOLrKrK0
 naGhwO4WQZTu1fNSTU/b5qTTnW2iyBNQMkp18WTTVYpq4rq6k6T9YT8KE6Dw3/tx9aGhqldHL
 cLsezl6uRsCFsY6H2VNTK9/ZxeTRQXlNQZTAVp/BNMVYgofW1n0gLUzzaDAkq+ZTm13zqInam
 vPxXua1Go/cBLImHOJWG/OfWnftA6NOkt3ekvT3HjDlDpkQ9HkrSCwbVOfwRKOUQr2Ff44eyu
 y5CHeD7HS5iFvS666JYvqxokWzDP8fA/HdxBndNHcRnsXP+MSfIW5oWpg/8j2Dyt9GsVTRiJ5
 pD4q7bLO3ipU0Lr2UgljwPxtZYxKLaIpsDb6S8PxMvDBgPeycFquigULtEdo3XN12KszpM28+
 NHQB+ElRqQXaKXdVSr5QpsF53v2oiM9+qCNgTaZDUqhsP5OMPi34A6KRm5nSzMFLP+VDnYZrP
 PRqmUSYiYq31+9YBx8z+5Y6PXyPwI6tZ+v2+AidJRQKAKcHY7dG0OjHhTyAD0bG6zCbDI0Ir4
 vinG2cAzZ2sfsDJupUB5K2X7ur3ZZ+pHdjwa5EdMfrzoNe3fhyqqv3a5ZCdKDvcXmY6nlM+L4
 v9oU/M5r30q7/AWihpyojBwBvJjFSR13qQuwtLuwI2Y1CousVqAd5cQCfD6QHuw4XAg2jOVOZ
 w8p8K9bQ2fuSKp4B9npetAJ4rHC2kl9lSMdFw3bEO1gNrROpBMcxREpOGwGMqoKayXhKR02yv
 jHU1w7PJc/5sAGIU/4m0oPRAmBrNN0ienWcl6GC7ifKO7LsUAZCKfyeEfiobK8d4E/+ob+pzJ
 S/DRWFY0ZnTNxSQx3QEyY+GxLPvvVn1T8Dp1E8HI3HpChatgqx7E2SsiuBvn3hSvH78RxzcVj
 uJg6SoU3orCz60HfcOOmSCPDJrahSXb6Jm0bSJbU2TBvWA+L7vgMf2v2YnmVtA2TSJrDCmgak
 9TggFT4NGuqdGE2Lt5GQp0h0rW6R9CUu9wzRhVQUFfoTO8t4IYJCJ+/eNtHzROdvedb4NT8gU
 q0Ce1+dAaVVMtL4tEfBX74TR78DpDZD27d5MYuJoCUsV0C/bHxpyGsN9k95PRHiuWvNT3rGHP
 7XmhBSFuyUjc8BKVhy9Pap5YwM04YO52MEsoOZ5QKTbxFY+iDMurGrx+EAvWqqMAED0PyKvwW
 b3hl3wi+u+MKVnh1N6mbKW4m8eGNc2tPvDiKP2SShOc7sUdIYchEFCeTvL/Wxgswjdrfr05Tk
 3r75bKPnZbCPNZu5vf4xp62R9bYxYHVslAIafsgjpR0YbGdqPSobsJV6vIZB4vKS3bHnfsQiM
 /HxLfq81JQRNXFyxUKdkE2pFOO1BjhqLwoDmbdqNpq9Cfs0aWm/OBCDm6XhEUH1PI12rErkGg
 qiKLoxcWgbU0iE1PLzpp7IQEYCUCCug+VfrVL7RZYYMDcFgTGXuK8AMravhGc2E0+JuErIHiB
 cjKU5f74Fws6n641A6b2pbJFllqXuZ6+xdACAUBwO22fW7RtShNkEaLUdVpx3SXbhCBOs15ov
 5ME5J8ofEQVC8mOEKoAQci9xsO6D5ATnJYxxTvR5Wb/g4jsC4VDLgvYCDa9fnpR8z72kI6BVW
 /0O3BEsitZ8crCFedOwr12Y2J7Ubc0YTkjsN1vzLnT0ye6jdzWjNUSpECsw7r0FPvBseN/RQF
 zIZjUPjmcjlKGemGClYBK52NR6YkoTJHyc+Oa8XMEzBU8F3eulRNjsIYN2Rf09GrEhC4TP9in
 1jdXmuc5EvuGeT5HHC1EG7chhRHoP8pGn6AhoFdLLUuPFdRbo1EcLd4sbxlI45RR3+xMy63E4
 jMQQ8ehL4VJlwEiRdSe9jXzSvyMTqh2Zl/YbT466PcTzVGMu082L9H4f1Mrqq/hnqQ00vqb0O
 FdmgafnpOMjBdFv1QiMd5ylfSrd72GTjC2+UUbwoauTPQaul9xfKhYlQeNoxEa68ZnnR2foIb
 ycnsih53sX+rH5Kp1WMKFc9xk8IvxLgILKR/dsj0NHEmZEaORDygG1hhg/d97qeeUAAUB+l45
 4yJ1wfOJEFViUaMj7+WE/VWXXvhNGYxiO4VbU0LEbCnQ/KlwbadiNLUoX5STbvIPIJC4wF8R4
 CYAoVZ01uFr3/4Gxvrb+EeX2NUE3Rydh/PrnRLQOxI+OREWAM2Thjuty8MmfKB9CgLixqDsyq
 Jk2oWVfBjYr3qRU60fQg2KGewB94w+YZ3nlam4pRKbzK0CFEOlEYoQwMRq9cD2OZ4hMJvCJgH
 PFmJkjWqk7hDBgDZcfDA+RpOc5+2qsmG08co+M83q2A7kAlZIVI8yTZqLtwJcbIsEZEiVyVty
 iqtnxTCWc4UEummGrh4R19jHUr6uHer1Ys0fDDNYCji1cJw420Uos5VMOTent2vB1tcHvMO7w
 quYvV9onHrHtnxcONax8vuYXrdoiCN17N/9MwyGQntX9zPOBb3hOXbBBDPfeYhFBeFeaA8m30
 UzZ0aDM2pURHliL2rCCh2N6TAeiRGu4cD5ZjMZvH6uKEhg4imxroivGVfh1WRk/AV69z76WQ0
 mkDPUeLbBts67rvdXsXSuUeXpHCrDWYCsn4TKkP/ywXf1bmyYhOjhowVmQ3yY0oIruWYULbD0
 D4dPCQqNkoPNOP+VobNTekDfyIfn/lv1Okt/VXsXEGGXgrq7oEXMbXGEX0M1uJer5C3SeS3wz
 2Tjov3O9Om3Gzdc8nhJhenpiuSlkY10vm0EHgdbLkxMQp5yju3yJA/lxJp0IrnV6WGDFPF0C1
 sY9uV2iqIFd4VxG9mjkcUZo9Gx1/bg8xspQpP3BYjBkwXqkm3jFvYKLr3N0mVEOjC6bN8njPC
 wzYDmG6nRLrpPiMm/DtI+4zpoud9eooH1cy0YeZNA7EM6OJ7Zi2dVSoMJZxg1ujnbISuoA1Of
 EMvU43Lj3lzTI3iL6KH+cRDyZ+zPoUf2lZg6tZUg6mvmgwGd4sLEjTiUakqm2pMkBjDFSP/9v
 Cc7Qlx3g4MjK7zC5b/rqukZ9qMxbVWNjzyf9NcqPQBHtk9Z9MyidPww+POvRZnNFDva1daxym
 hiYarPcrFcViqMEJvz1fOb3elPkF/jR2ytdlEDaqQvP/1ssG1jzokoEdDoeRfEeS+JEqypW8E
 Kg/U9UPed+8Szfo1zhkF5O69sh4P0vOC/DYaVImGVPbDjg9SCmaDHN2eM3hXRVa52OLdEPzpw
 Tz/+qVkJ5I6kiz0/JOUnvuGkEUlwub4EAWFdJHFs4TW6eRqrgTeoxretaLXKOKgsObX0BUBN1
 LGTA4DrbIjaxBxIVJ4mvzzlW3tYo1np8PUp8xvND09TgzcRk/30y/8gpAahQcHg/ZIjHQEbGk
 TyyPiaq6knCcNP4M1xR51oYKHXtZvGmWGJ5PnQCaNXEeoMJEwF3+DY5cO1ch7slFe4Q18XIcd
 K3fWnfsYa1A+0KjyhEPkqjh3D+hftkhY8pfkivS8/CvZv6KTKl9gZagB83ijgjdKJnycU9IBt
 0f0CxKOGBADXQLbvWLF6r1BJwcoc3i5RzGeudBG4mVrANYGR4FsUsg3fydADMbfeQ6oIoe5Bq
 fjLBl9JdbFqdqML3nmiwrw9XYOum1z/EQ3hZSGFzz09UGxl53lZjl0pqRbq7myHfWJlvUxenU
 /CoxSViI3Jkz9ST1OBclXwaTqTM9JpZwy0ZfEg5ZWY3yC8koLjr0OJ/BVDTve7SQejnP5u2wy
 TjDTjDoZcvxlV2s+oVAfoRQUzxKKsvlFSAafYy0XrXamgdH5HVJ8nrnghtpJAYnGclH+46NDz
 /FO4gcTa6d+vMNtQvmp9VjUssj8xrZ9fL8J2yNi1rA==

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.
=2D--
 src/dbus-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 5e2c83d52..42539116a 100644
=2D-- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -144,6 +144,8 @@ const char *gap_appearance_to_icon(uint16_t appearance=
)
 			return "scanner";
 		}
 		break;
+	case 0x2a: /* Gaming =E2=80=94 Assigned Numbers, section 2.6.2 */
+		return "input-gaming";
 	}
=20
 	return NULL;
=2D-=20
2.47.3

