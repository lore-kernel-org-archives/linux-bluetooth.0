Return-Path: <cyrus@holtmann.org>
Message-ID: <4C80ABE8.9080309@gmail.com>
Date: Fri, 03 Sep 2010 10:03:52 +0200
From: Santiago Carot-Nemesio <sancane@gmail.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@epx.com.br>
CC: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: CSP implementation for MCAP
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br>
In-Reply-To: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On 09/02/10 20:58, Elvis Pfützenreuter wrote:
> This is the repository for the CSP implementation, rebased over the recently accepted MCAP, for your appreciation:
>
> git://gitorious.org/bluez-epx/bluez-epx.git csp
>

I have been divin in CSP code and at first look I found some issues that 
I would like discuss with you.

The call to function mcap_sync_stop(mcl) it's only neccesary in static 
close_mcl function. You can remove the second call in line 799 when user 
closes explicitly the mcl due that first sync_stop will be called from 
watcher set in control channel when its socket is closed.

Second thing is related to code structure. Because standard op codes and 
close synchronization protocol have separate logic, it may better put 
csp parameters away from mcl in a separate structure to avoid mess all 
protocol logic in a big mcl structure, I was thinking in something like 
this:

struct mcap_mcl {
	/* Op code parameters */
	....
	struct	mcap_csp	*csp;
}

struct mcap_csp {
	uint64_t	base_tmstamp;
	struct timespec	base_time;
	guint		local_caps;
	guint		remote_caps;
	guint		rem_req_acc;
	guint		ind_expected;
	MCAPCtrl	csp_req;
	guint		ind_timer;
	guint		set_timer;
	void		*set_data;
	gint		dev_id;
	gint		dev_hci_fd;
	void		*csp_priv_data;
};

Because CSP is optional we can reserve memory for csp only when we will 
use Clock Synchronization protocol.
Of course, I know that it depends on invidivual taste, but I would like 
to comment this issue.

Comments are welcome.

Regards.


