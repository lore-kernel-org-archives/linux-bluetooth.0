Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005051518.45474.jcaden@libresoft.es>
Date: Wed, 5 May 2010 10:22:16 -0300
Cc: "Santiago Carot-Nemesio" <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
Message-Id: <E956E54B-C1C5-4FCA-A677-1E549CF3B3D2@signove.com>
References: <1272959741.2182.123.camel@mosquito> <F4813D96-A6B5-4755-ABB8-4C7D880B05D8@signove.com> <483C27C6-11BB-459F-AD43-F0734EE0F3A9@signove.com> <201005051518.45474.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> So you mean do fd-passing with the pipe file descriptor to the client and then HDP will write the data in the L2CAP socket using splice, am I right?

I guess they meant using splice for the pipe (because as far as I understood, it is for pipes only), so the data exchanged between bluez and application is zero-copy.