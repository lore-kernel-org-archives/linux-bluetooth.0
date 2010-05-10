Return-Path: <cyrus@holtmann.org>
Subject: Re: Data transmission and reconnections in HDP
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <u2paa32413d1005091808n54065c98o26ac89de1dde8770@mail.gmail.com>
Date: Sun, 9 May 2010 23:31:22 -0300
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	=?iso-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <536E0C33-0FB5-4A71-AE8A-5C96F2ABEA0F@signove.com>
References: <201005071302.36198.jcaden@libresoft.es> <20100507120859.GD12461@vigoh>  <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>  <20100507195704.GC4857@vigoh> <8D8F1AA1-A7C1-4636-BB75-1EF1A2E1A556@signove.com> <u2paa32413d1005091808n54065c98o26ac89de1dde8770@mail.gmail.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> 
> Automatic reconnection should happen only in the case HDP has
> disconnected the transport for power-saving, because the data layer is
> idle, doesn't it? So will (b) ever happen? In the case the connection
> is dropped (loss of signal etc) the data layer should always be
> notified IMO (case c).

MCAP spec says that 

"Because the Source and Sink assign a unique MDL ID when a new MDL is formed, using this same ID later allows a reconnection to the same context after they are intentionally closed or unintentionally broken (possibly from interference or temporarily moving out of range)." (Page 27)

HDP spec always talks mentions "reconnection" and "power saving" near each other, but I guess it is in a broader context (not having to renegotiate every data channel after an involuntary break-up also saves power).