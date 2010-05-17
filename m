Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/1] Makes extract_svclass_uuid function public
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1274102035.26613.7.camel@localhost.localdomain>
Date: Mon, 17 May 2010 10:24:33 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1A53072B-0977-4455-9337-5948D0B2AFA6@signove.com>
References: <1273763316-28425-1-git-send-email-epx@signove.com> <1274102035.26613.7.camel@localhost.localdomain>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Indeed I was. sdp_get_service_classes returns a list of UUIDs already, =
so no need to extract.=20

On 17/05/2010, at 10:13, Marcel Holtmann wrote:

> Hi Elvis,
>=20
>> This patch makes the extract_svclass_uuid function public,
>> so it may be used by applications that link to libbluetooth.
>=20
> I really like to see how you are planning to use this function. It is
> not a problem to make it public, but I am concerned you might be
> misusing it.
>=20
> Regards
>=20
> Marcel
>=20
>=20
