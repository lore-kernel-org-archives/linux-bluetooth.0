Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: Data transmission and reconnections in HDP
Date: Mon, 10 May 2010 09:53:57 +0200
Cc: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <201005071302.36198.jcaden@libresoft.es> <u2paa32413d1005091808n54065c98o26ac89de1dde8770@mail.gmail.com> <536E0C33-0FB5-4A71-AE8A-5C96F2ABEA0F@signove.com>
In-Reply-To: <536E0C33-0FB5-4A71-AE8A-5C96F2ABEA0F@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005100953.57556.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Monday 10 May 2010 04:31:22 Elvis Pfützenreuter escribió:
> > 
> > Automatic reconnection should happen only in the case HDP has
> > disconnected the transport for power-saving, because the data layer is
> > idle, doesn't it? So will (b) ever happen? In the case the connection
> > is dropped (loss of signal etc) the data layer should always be
> > notified IMO (case c).
> 
> MCAP spec says that 
> 
> "Because the Source and Sink assign a unique MDL ID when a new MDL is formed, using this same ID later allows a reconnection to the same context after they are intentionally 
closed or unintentionally broken (possibly from interference or temporarily moving out of range)." (Page 27)
> 
> HDP spec always talks mentions "reconnection" and "power saving" near each other, but I guess it is in a broader context (not having to renegotiate every data channel after an 
involuntary break-up also saves power).--

Completely agree with this, reconnections should be performed  until the 
data channel is deleted (this mdlid is no valid anymore for reconnections)
or until one of the sessions is closed, the remote or the local.


