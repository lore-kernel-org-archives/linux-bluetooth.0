Return-Path: <cyrus@holtmann.org>
Subject: Re: CSP implementation for MCAP
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <4C80ABE8.9080309@gmail.com>
Date: Fri, 3 Sep 2010 09:53:18 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4EB76459-A7E4-4501-81A1-A12110648919@signove.com>
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br> <4C80ABE8.9080309@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Sep 3, 2010, at 5:03 AM, Santiago Carot-Nemesio wrote:

> Hi Elvis,
> 
> On 09/02/10 20:58, Elvis Pfützenreuter wrote:
>> This is the repository for the CSP implementation, rebased over the recently accepted MCAP, for your appreciation:
>> 
>> git://gitorious.org/bluez-epx/bluez-epx.git csp
>> 
> 
> I have been divin in CSP code and at first look I found some issues that I would like discuss with you.
> 
> The call to function mcap_sync_stop(mcl) it's only neccesary in static close_mcl function. You can remove the second call in line 799 when user closes explicitly the mcl due that first sync_stop will be called from watcher set in control channel when its socket is closed.
> 
> Second thing is related to code structure. Because standard op codes and close synchronization protocol have separate logic, it may better put csp parameters away from mcl in a separate structure to avoid mess all protocol logic in a big mcl structure, I was thinking in something like this:
> 
> struct mcap_mcl {
> 	/* Op code parameters */
> 	....
> 	struct	mcap_csp	*csp;
> }
> 
> struct mcap_csp {
> 	uint64_t	base_tmstamp;
> 	struct timespec	base_time;
> 	guint		local_caps;
> 	guint		remote_caps;
> 	guint		rem_req_acc;
> 	guint		ind_expected;
> 	MCAPCtrl	csp_req;
> 	guint		ind_timer;
> 	guint		set_timer;
> 	void		*set_data;
> 	gint		dev_id;
> 	gint		dev_hci_fd;
> 	void		*csp_priv_data;
> };
> 
> Because CSP is optional we can reserve memory for csp only when we will use Clock Synchronization protocol.
> Of course, I know that it depends on invidivual taste, but I would like to comment this issue.

Sounds sensible.

> 
> Comments are welcome.
> 
> Regards.
> 
> 

