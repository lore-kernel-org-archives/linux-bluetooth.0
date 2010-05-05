Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: HDP proposed API
Date: Wed, 5 May 2010 15:36:40 +0200
Cc: "Santiago Carot-Nemesio" <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
References: <1272959741.2182.123.camel@mosquito> <201005051518.45474.jcaden@libresoft.es> <E956E54B-C1C5-4FCA-A677-1E549CF3B3D2@signove.com>
In-Reply-To: <E956E54B-C1C5-4FCA-A677-1E549CF3B3D2@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005051536.40471.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Wednesday 05 May 2010 15:22:16 Elvis Pfützenreuter escribió:
> > So you mean do fd-passing with the pipe file descriptor to the client and then HDP will write the data in the L2CAP socket using splice, am I right?
> 
> I guess they meant using splice for the pipe (because as far as I understood, it is for pipes only), so the data exchanged between bluez and application is zero-copy.--

I'm reading splice documentation and I understand that can be used with any type of fd, 
but one of the fd should be a pipe. This is ok for that case.

I see one problem. The pipes are unidirectional so for a full duplex data channel
HDP will need two pipes (what means 4 fd and pass 2 to the client, one for read 
and other for write). We should find an easy way to solve this. Proposals are
welcome :)

