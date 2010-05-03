Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Health Device Profile API
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <o2k2d5a2c101005030651ke836a891q7544e54e89201777@mail.gmail.com>
Date: Mon, 3 May 2010 11:23:13 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7248B550-7628-461E-B0BF-EDE8152B6200@signove.com>
References: <1272591852-4961-1-git-send-email-epx@signove.com> <o2k2d5a2c101005030651ke836a891q7544e54e89201777@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the case of HDP, the same device may support two different roles (source and sink) on a single SDP record. For example, a data concentrator that collects data from sensors and forwards to a PC will have a number of source and sink MDEPs, all of them under a single SDP record and a single "listening" L2CAP socket for MCAP control channel. When a remoty party connects, only the data channels that match are connected (both of same data type, one side source, other side sink).

That's why we chose a single interface, a generic RegisterRole(), and role appears again in EndPoint dict.

> In case of MDEP we might want to have two interfaces
> org.bluez.HealthSink and org.bluez.HealthSource, this should fix the
> reusing the interface name with different methods in adapter path and
> device path, internally the code can take care of matching local ones
> with remotes ones, well at least we did that for a2dp sink/source
> although it is a completely different profile I think it might be
> useful to have a similar logic in this case otherwise the ui (if there
> is any in this case) has to figure out a lot of details to connect,
> again in a2dp there is also sink/source concept and support for
> multiples remote/local seps but we try to hide as much as possible in
> the API.
> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer

