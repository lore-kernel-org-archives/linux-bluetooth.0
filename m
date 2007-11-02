Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300711021151h50e8e7cbw19a8f3597395e04c@mail.gmail.com>
Date: Fri, 2 Nov 2007 12:51:49 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <472AF813.4050104@grobelny.oswiecenia.net>
MIME-Version: 1.0
References: <200711012303.08727.tomasz@grobelny.oswiecenia.net>
	<d89ddf300711011950y35631fdex206d136d1b5f718e@mail.gmail.com>
	<472AF813.4050104@grobelny.oswiecenia.net>
Subject: Re: [Bluez-users] A2DP sink
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Tomasz

I should say the btsco module in the bluetooth-alsa project.

a2recv doesn't deal directly with sdp or act like a bluez-utils
service. It also uses an oss audio device for output which can be a
pain.

Brad

On 11/2/07, Tomasz Grobelny <tomasz@grobelny.oswiecenia.net> wrote:
> Brad Midgley pisze:
> > Tomasz
> >
> > There is a prototype for this in the btsco project. The app is called a2recv.
> >
> You mean the bluetooth-alsa project? I'll try it out (as soon as I buy
> bluetooth dongle for my second computer). But out of curiosity: what's
> wrong with a2recv that it has prototype status? In other words: what
> needs to be done for it to be considered production quality/official?
> --
> Regards,
> Tomasz Grobelny
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
