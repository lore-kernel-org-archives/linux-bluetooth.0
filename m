Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API(0.5)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005181010.06376.jcaden@libresoft.es>
Date: Tue, 18 May 2010 11:05:34 -0300
Cc: ngh@isomerica.net, "Gustavo F. Padovan" <gustavo@padovan.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org, raul.herbster@signove.com
Message-Id: <D8266AB8-152E-4ECB-8618-CC9EE75D70DF@signove.com>
References: <201005171654.36923.jcaden@libresoft.es> <20100517232056.GC19907@vigoh> <1274150562.3559.78.camel@strawberry> <201005181010.06376.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On May 18, 2010, at 5:10 AM, José Antonio Santos Cadenas wrote:

<snip>

>> Has any thought been given regarding support for MCAP clock
>> synchronization?  IEEE-20601 is mostly agnostic to the transport, but
>> this is one point where transport-specific information is exposed within
>> the 20601 protocol (via the MDS object's Mds-Time-Info attribute).  I'm
>> not aware of any devices which currently support clock synch (my code
>> included), so I'd argue this isn't a blocking feature for the first
>> release.
> 
> Yes, we (Santiago and me) and Elvis (and his team) are planning to continue 
> this work over MCAP in the next weeks.
> 
> Elvis, can you give more details about this?

Not yet, we plan to begin working on CSP this week.

