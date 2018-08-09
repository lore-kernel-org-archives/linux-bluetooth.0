Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
References: <SN1PR02MB37262EB4E2CDA30680DB07FB82250@SN1PR02MB3726.namprd02.prod.outlook.com>
In-Reply-To: <SN1PR02MB37262EB4E2CDA30680DB07FB82250@SN1PR02MB3726.namprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Aug 2018 11:01:58 +0300
Message-ID: <CABBYNZ+rsiu2Tg5mvMNSvaR0vzxu6vEn_v4qKxK-GEDYjGZ2TA@mail.gmail.com>
Subject: Re: Diffie-Hellman vulnerability note on CERT
To: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jamie,
On Thu, Aug 9, 2018 at 9:38 AM Jamie Mccrae <Jamie.Mccrae@lairdtech.com> wr=
ote:
>
> Hi,
> It seems that CERT now has a public disclosure page about the recent Diff=
ie-Hellman curve encryption vulnerability detailing software revisions that=
 have the issue and versions that have it fixed. It currently shows unknown=
 next to the Linux Kernel so might be a good idea to update this with the c=
orrect information? https://www.kb.cert.org/vuls/id/304725

For BR/EDR that is on the controller so there is nothing much we can
do about, for LE this is host side but afaik we do perform the
necessary checks so we should probably contact them using the link in:
https://www.kb.cert.org/vuls/id/CHEU-AWKKAG

@Marcel: Do you have any comments on this?

--=20
Luiz Augusto von Dentz
