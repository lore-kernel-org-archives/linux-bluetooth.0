Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 8 Jun 2011 09:46:46 -0300
Message-ID: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com>
Subject: Read clock not implemented in management
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: sancane <sancane@gmail.com>,
	=?UTF-8?Q?Elvis_Pf=C3=BCtzenreuter?= <epx@signove.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago and Elvis,

Read clock is not implemented in the management interface. Does it
break something important in the health plug-in?

I am not aware when hciops will be dropped, but the fact is: if the
system uses mgmtops instead of hciops health will not work properly.

BR,
Claudio.
