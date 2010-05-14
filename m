Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API (ver 0.3)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005141000.51935.jcaden@libresoft.es>
Date: Fri, 14 May 2010 09:20:19 -0300
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Santiago Carot <sancane@gmail.com>,
	Raul Herbster <raul.herbster@signove.com>
Message-Id: <B632DD4E-3F0F-44A7-A5A3-5816F9E79C5D@signove.com>
References: <201005121126.12859.jcaden@libresoft.es> <201005131002.24806.jcaden@libresoft.es> <AANLkTimjua-P8DgvGidKaIgRvCScuP4mGTi4Wm82-O-N@mail.gmail.com> <201005141000.51935.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> 	- Giving this data to HDP is not only for registering a SDP record but 
> also for doing checks when a connection is received, so this data will be 
> finally passed to HDP.
> 	- The HDP client doesn't know all the data that should be published in 
> the SDP record, like PSM's where MCAP is waiting for connections or MCAP 
> supported features (note that MCAP is not exported by D-BUS).

Also, MCAP uses dynamic PSMs, one more reason to encapsulate the SDP record generation/parsing. If the application had to do this, it would have to find two free PSMs (ugly).

