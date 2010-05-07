Return-Path: <cyrus@holtmann.org>
Subject: Re: Data transmission and reconnections in HDP
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <20100507194919.GA4857@vigoh>
Date: Fri, 7 May 2010 16:55:13 -0300
Cc: =?iso-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BC6ABF7A-4847-4DDE-B3D6-584BEF215D65@signove.com>
References: <201005071302.36198.jcaden@libresoft.es> <20100507120859.GD12461@vigoh> <82D1897F-4DEE-47F9-BD00-57087F182C3D@signove.com> <20100507194919.GA4857@vigoh>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> 
> Also I still have to check the case when the remote side requests a
> disconnect. I'm adding these stuff to my todo list an I'll work on it
> soon.

I imagined the case when send(msg) returns, the msg is still in output buffer and then the connection drops due e.g. to faint signal (not voluntary close). (I understand ERTM guarantees atomic delivery of message, but I don't think it blocks send() until the message is safely at the other side.)