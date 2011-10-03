Return-Path: <cyrus@holtmann.org>
Subject: Re: Inquiry Failed with status 0x0c
From: Alberto =?ISO-8859-1?Q?Jos=E9_Rodr=EDguez_?=
	 =?ISO-8859-1?Q?Rodr=EDguez?= <ajrodriguez@blulabs.es>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <CAMxgYMOfCRi6JiSQogVFVA52Ax9+hnSn3O4k3-2Xw9BerEji2g@mail.gmail.com>
References: <1316780153.3433.6.camel@localhost>
	 <1317375540.1582.8.camel@localhost>
	 <CAMxgYMOfCRi6JiSQogVFVA52Ax9+hnSn3O4k3-2Xw9BerEji2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 03 Oct 2011 12:37:24 +0200
Message-ID: <1317638244.1583.9.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

0x0c means that the command is disallowed with the current adapter's
status. I think that I executing two incompatible commands concurrently,
but my main problem is that the inquiry session remains opened although
the adapter never initiate the discovering proccess.

El lun, 03-10-2011 a las 15:55 +0530, Vaishali D escribió:
> Look carefully on this , I think the status 0x0c doesnt mean failure ,
> It means success.
> Regards

