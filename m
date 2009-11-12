Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFBF5AE.9090107@gmail.com>
Date: Thu, 12 Nov 2009 12:46:54 +0100
From: sancane <sancane@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: =?ISO-8859-1?Q?Pedro_de_las_Heras_Quir=F3s?= <pheras@gsyc.es>,
	scarot@libresoft.es,
	=?ISO-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Subject: HDP & MCAP developed for Bluez
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I would like to announce to you that we have finished our open
source MCAP-HDP implementation for Bluez. We've successfully tested it
against a Nonin Onyx II 9560 using the el2cap Gustavo's kernel
implementation.

We're planning to release it under GNU/GPL v3. If you are interested, we
can add it to Bluez official library. We are open to any suggestion or
recommendation.

At current moment we are working on it to set the code in a more stable
state. We will plan to upload our libraries in next few days, we will
announce here when the code is available.

We have noticed that it is necessary to add some functionalities to the
SDP implementation (which affect to HDP records), at the current moment,
we have included it in HDP, but we think that it is better to include it
in SDP. If you want, we can submit a patch to add it.

You can get more information about the project in
http://openhealth.morfeo-project.org/

best regards!
