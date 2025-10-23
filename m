Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256EE255240;
	Thu, 23 Oct 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203147; cv=none; b=LAifihkW10tdZTqn1s8LPB1UJ/sidJC+ia4pYQgHbtX8AD0rwog4oqJJSM1fC6vBviFPvdELPvL641dubcOgOaCSh37x3a/rOk+Mq2R4vtb0NNWVK/99lPZRzGE5Bim9tjHg1UJ7RAn4d6op1lycgC4aXiih7Oz3pWybXl4WxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203147; c=relaxed/simple;
	bh=5ICGfVzuTLy8E+nH3lwiFFsENF5dS+1c1viiPVRplys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxXM99GvSYbSbCivrX/2ZI+lIcENQUtC14+OWIsZH4oz6gJULF55BSxCQck0ChfgLH6Mj80oDt1HdduIwhkNlDUgqug/72fQsPRIViqMRcyDcqgoIg1iBmQBhwyIv6PQk09+lt1CWl1a6cUDL0T9JWf1difFSoIJibXkEyuAr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YD4u2GXQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YD4u2GXQ"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59N75V5V02070782, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761203131; bh=5ICGfVzuTLy8E+nH3lwiFFsENF5dS+1c1viiPVRplys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YD4u2GXQd8yzV06ES2Ns8OltwA7wPNyidhhHp8ESQFA+ez4e+W7UTmL9Kqzk7nTUE
	 99vVCRhlSHfdhu+a/rA2ULeRJswpIazCnsvt1CUJi4XxZWW4Y3uYhwQ+6V9DnadZ9s
	 lP45Gz6Ye7YWa7ODdOt7nFrutspI1JF9AURiUxZQdHPSeRVY0yUrhn3G/QeMEMUMWX
	 rRAtuiJvAdjDzydq5q3MzdmLd4WuGIB83xD/5KIVWSTerFAshxUi+uu8JaYx6RwApY
	 dSOIaRHrX0I6+ExuQpA168OUTXRbunY9NmW/oLAmYH2k40fcSrcseNQgbTuuy4Yic+
	 jfcWKzfpUB/Tg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59N75V5V02070782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:05:31 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 23 Oct 2025 15:05:31 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::2514:51f7:92e3:7d6a%9]) with mapi id
 15.02.1544.027; Thu, 23 Oct 2025 15:05:31 +0800
From: Max Chou <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        "niall_ni@realsil.com.cn"
	<niall_ni@realsil.com.cn>,
        "zhu_qing@realsil.com.cn"
	<zhu_qing@realsil.com.cn>,
        Chih-Hsiang Wang <wangchihhs@realtek.com>,
        "brenda.li@ublnx.com" <brenda.li@ublnx.com>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: Add the support for RTL8761CUV
Thread-Topic: [PATCH] Bluetooth: btrtl: Add the support for RTL8761CUV
Thread-Index: AQHcQ+r0sbqVdn7QDE+56GM9UlkwJ7TPTiSQ
Date: Thu, 23 Oct 2025 07:05:31 +0000
Message-ID: <4c38283c501d47a89a5c5d3f731de031@realtek.com>
References: <20251023070221.18657-1-max.chou@realtek.com>
In-Reply-To: <20251023070221.18657-1-max.chou@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogTWF4IENob3UgPG1heC5jaG91QHJlYWx0ZWsuY29tPg0KDQpBZGQgdGhlIHN1cHBvcnQg
Zm9yIFJUTDg3NjFDVVYgQlQgY29udHJvbGxlciBvbiBVU0IgaW50ZXJmYWNlLg0KDQpUaGUgZGV2
aWNlIGluZm8gZnJvbSAvc3lzL2tlcm5lbC9kZWJ1Zy91c2IvZGV2aWNlcyBhcyBiZWxvdy4NCg0K
VDogIEJ1cz0wMiBMZXY9MDEgUHJudD0wMSBQb3J0PTAwIENudD0wMSBEZXYjPSAxMyBTcGQ9MTIg
ICBNeENoPSAwDQpEOiAgVmVyPSAxLjEwIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgTXhQ
Uz02NCAjQ2Zncz0gIDENClA6ICBWZW5kb3I9MGJkYSBQcm9kSUQ9Yzc2MSBSZXY9IDIuMDANClM6
ICBNYW51ZmFjdHVyZXI9UmVhbHRlaw0KUzogIFByb2R1Y3Q9Qmx1ZXRvb3RoIENvbnRyb2xsZXIN
ClM6ICBTZXJpYWxOdW1iZXI9MTAwMDANCkM6KiAjSWZzPSAyIENmZyM9IDEgQXRyPWEwIE14UHdy
PTEwMG1BDQpJOiogSWYjPSAwIEFsdD0gMCAjRVBzPSAzIENscz1lMCh3bGNvbikgU3ViPTAxIFBy
b3Q9MDEgRHJpdmVyPWJ0dXNiDQpFOiAgQWQ9ODEoSSkgQXRyPTAzKEludC4pIE14UFM9ICA2NCBJ
dmw9MW1zDQpFOiAgQWQ9MDIoTykgQXRyPTAyKEJ1bGspIE14UFM9ICA2NCBJdmw9MG1zDQpFOiAg
QWQ9ODIoSSkgQXRyPTAyKEJ1bGspIE14UFM9ICA2NCBJdmw9MG1zDQpJOiogSWYjPSAxIEFsdD0g
MCAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQpFOiAg
QWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9ICAgMCBJdmw9MW1zDQpFOiAgQWQ9MDMoTykgQXRy
PTAxKElzb2MpIE14UFM9ICAgMCBJdmw9MW1zDQpJOiAgSWYjPSAxIEFsdD0gMSAjRVBzPSAyIENs
cz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQpFOiAgQWQ9ODMoSSkgQXRy
PTAxKElzb2MpIE14UFM9ICAgOSBJdmw9MW1zDQpFOiAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14
UFM9ICAgOSBJdmw9MW1zDQpJOiAgSWYjPSAxIEFsdD0gMiAjRVBzPSAyIENscz1lMCh3bGNvbikg
U3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQpFOiAgQWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14
UFM9ICAxNyBJdmw9MW1zDQpFOiAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9ICAxNyBJdmw9
MW1zDQpJOiAgSWYjPSAxIEFsdD0gMyAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9
MDEgRHJpdmVyPWJ0dXNiDQpFOiAgQWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9ICAyNSBJdmw9
MW1zDQpFOiAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9ICAyNSBJdmw9MW1zDQpJOiAgSWYj
PSAxIEFsdD0gNCAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0
dXNiDQpFOiAgQWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9ICAzMyBJdmw9MW1zDQpFOiAgQWQ9
MDMoTykgQXRyPTAxKElzb2MpIE14UFM9ICAzMyBJdmw9MW1zDQpJOiAgSWYjPSAxIEFsdD0gNSAj
RVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQpFOiAgQWQ9
ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9ICA0OSBJdmw9MW1zDQpFOiAgQWQ9MDMoTykgQXRyPTAx
KElzb2MpIE14UFM9ICA0OSBJdmw9MW1zDQpJOiAgSWYjPSAxIEFsdD0gNiAjRVBzPSAyIENscz1l
MCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQpFOiAgQWQ9ODMoSSkgQXRyPTAx
KElzb2MpIE14UFM9ICA2MyBJdmw9MW1zDQpFOiAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9
ICA2MyBJdmw9MW1zDQoNClNpZ25lZC1vZmYtYnk6IE1heCBDaG91IDxtYXguY2hvdUByZWFsdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMgfCAxMyArKysrKysrKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0cnRsLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jIGluZGV4IDZh
YmQ5NjI1MDJlMy4uMzI5NTU0ZjIzNTQyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ibHVldG9vdGgv
YnRydGwuYw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYw0KQEAgLTcyLDYgKzcyLDcg
QEAgZW51bSBidHJ0bF9jaGlwX2lkIHsNCiAJQ0hJUF9JRF84ODUxQiA9IDM2LA0KIAlDSElQX0lE
Xzg5MjJBID0gNDQsDQogCUNISVBfSURfODg1MkJUID0gNDcsDQorCUNISVBfSURfODc2MUMgPSA1
MSwNCiB9Ow0KIA0KIHN0cnVjdCBpZF90YWJsZSB7DQpAQCAtMjMwLDYgKzIzMSwxNCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGlkX3RhYmxlIGljX2lkX3RhYmxlW10gPSB7DQogCSAgLmNmZ19uYW1l
ID0gInJ0bF9idC9ydGw4NzYxYnVfY29uZmlnIiwNCiAJICAuaHdfaW5mbyAgPSAicnRsODc2MWJ1
IiB9LA0KIA0KKwkvKiA4NzYxQ1UgKi8NCisJeyBJQ19JTkZPKFJUTF9ST01fTE1QXzg3NjFBLCAw
eDBlLCAweGMsIEhDSV9VU0IpLA0KKwkgIC5jb25maWdfbmVlZGVkID0gZmFsc2UsDQorCSAgLmhh
c19yb21fdmVyc2lvbiA9IHRydWUsDQorCSAgLmZ3X25hbWUgID0gInJ0bF9idC9ydGw4NzYxY3Vf
ZnciLA0KKwkgIC5jZmdfbmFtZSA9ICJydGxfYnQvcnRsODc2MWN1X2NvbmZpZyIsDQorCSAgLmh3
X2luZm8gID0gInJ0bDg3NjFjdSIgfSwNCisNCiAJLyogODgyMkMgd2l0aCBVQVJUIGludGVyZmFj
ZSAqLw0KIAl7IElDX0lORk8oUlRMX1JPTV9MTVBfODgyMkIsIDB4YywgMHg4LCBIQ0lfVUFSVCks
DQogCSAgLmNvbmZpZ19uZWVkZWQgPSB0cnVlLA0KQEAgLTY2OCw2ICs2NzcsNyBAQCBzdGF0aWMg
aW50IHJ0bGJ0X3BhcnNlX2Zpcm13YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KIAkJeyBSVExf
Uk9NX0xNUF84ODUxQiwgMzYgfSwJLyogODg1MUIgKi8NCiAJCXsgUlRMX1JPTV9MTVBfODkyMkEs
IDQ0IH0sCS8qIDg5MjJBICovDQogCQl7IFJUTF9ST01fTE1QXzg4NTJBLCA0NyB9LAkvKiA4ODUy
QlQgKi8NCisJCXsgUlRMX1JPTV9MTVBfODc2MUEsIDUxIH0sCS8qIDg3NjFDICovDQogCX07DQog
DQogCWlmIChidHJ0bF9kZXYtPmZ3X2xlbiA8PSA4KQ0KQEAgLTEzMDEsNiArMTMxMSw3IEBAIHZv
aWQgYnRydGxfc2V0X3F1aXJrcyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IGJ0cnRsX2Rl
dmljZV9pbmZvICpidHJ0bF9kZXYpDQogCWNhc2UgQ0hJUF9JRF84ODUxQjoNCiAJY2FzZSBDSElQ
X0lEXzg5MjJBOg0KIAljYXNlIENISVBfSURfODg1MkJUOg0KKwljYXNlIENISVBfSURfODc2MUM6
DQogCQloY2lfc2V0X3F1aXJrKGhkZXYsIEhDSV9RVUlSS19XSURFQkFORF9TUEVFQ0hfU1VQUE9S
VEVEKTsNCiANCiAJCS8qIFJUTDg4NTJDIG5lZWRzIHRvIHRyYW5zbWl0IG1TQkMgZGF0YSBjb250
aW51b3VzbHkgd2l0aG91dCBAQCAtMTUyMCw2ICsxNTMxLDggQEAgTU9EVUxFX0ZJUk1XQVJFKCJy
dGxfYnQvcnRsODc2MWJfZncuYmluIik7DQogTU9EVUxFX0ZJUk1XQVJFKCJydGxfYnQvcnRsODc2
MWJfY29uZmlnLmJpbiIpOw0KIE1PRFVMRV9GSVJNV0FSRSgicnRsX2J0L3J0bDg3NjFidV9mdy5i
aW4iKTsNCiBNT0RVTEVfRklSTVdBUkUoInJ0bF9idC9ydGw4NzYxYnVfY29uZmlnLmJpbiIpOw0K
K01PRFVMRV9GSVJNV0FSRSgicnRsX2J0L3J0bDg3NjFjdV9mdy5iaW4iKTsNCitNT0RVTEVfRklS
TVdBUkUoInJ0bF9idC9ydGw4NzYxY3VfY29uZmlnLmJpbiIpOw0KIE1PRFVMRV9GSVJNV0FSRSgi
cnRsX2J0L3J0bDg4MjFhX2Z3LmJpbiIpOw0KIE1PRFVMRV9GSVJNV0FSRSgicnRsX2J0L3J0bDg4
MjFhX2NvbmZpZy5iaW4iKTsNCiBNT0RVTEVfRklSTVdBUkUoInJ0bF9idC9ydGw4ODIxY19mdy5i
aW4iKTsNCi0tDQoyLjQzLjANCg0K
