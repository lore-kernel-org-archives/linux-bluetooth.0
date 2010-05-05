Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <F4813D96-A6B5-4755-ABB8-4C7D880B05D8@signove.com>
Date: Wed, 5 May 2010 10:10:56 -0300
Cc: Santiago Carot-Nemesio <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
Message-Id: <483C27C6-11BB-459F-AD43-F0734EE0F3A9@signove.com>
References: <1272959741.2182.123.camel@mosquito> <201005041254.37990.jcaden@libresoft.es> <414EAFF0-4D91-488E-A19B-E0B063487B7D@signove.com> <201005051257.20525.jcaden@libresoft.es> <F4813D96-A6B5-4755-ABB8-4C7D880B05D8@signove.com>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> 
>> The d-bus writing option: we thing that is too much load for the dbus and that will be very
>> slow too. Because the change to xml formtat could be very expensive, and the amount of data
>> could be very big. Note tha 11073-20601 defines apdus of 65Kb (we think that this is too much for d-bus)
> 
> That's a good question for us to make in #dbus channel :) 

Ok, indeed D-BUS guys said that a fd (e.g. a pipe) is better, and suggested using pipes + http://en.wikipedia.org/wiki/Splice_(system_call)

