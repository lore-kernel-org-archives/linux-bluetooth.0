Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 21:06:15 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Isaiah Sarju <Isaiah.Sarju@Dartmouth.edu>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: RFCOMM channel 1 behavior differences
Message-ID: <20110813000615.GA32541@piper>
References: <4E45B5F1.4020807@Dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E45B5F1.4020807@Dartmouth.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Isaiah,

On 19:23 Fri 12 Aug, Isaiah Sarju wrote:
> Hello,
> 
> Does Ubuntu, linux kernel 2.6.38.10, running bluez 4.91-0ubuntu1
> have a special security policy for incoming rfcomm connections on
> channel 1, and not other channels?
> 

Most probably this is caused by a problem in how Ubuntu packages
BlueZ. 

Could you try this: edit /etc/bluetooth/main.conf and add "pnat-server"
to the DisabledPlugins field (perhaps you will need to uncomment that
line). Restart bluetoothd and see if it works.

> I ask this because I can create rfcomm connections between two
> computers on other channels (2, 3, 11, 13, etc.) but the listening
> computer refuses connections when connection requests come in for
> channel 1.
> 
> I use the following commands:
> 
> on listening computer:
> 	sudo rfcomm listen hci0 <channel>
> 
> on connecting computer:
> 	sudo rfcomm connect hci0 <BD_ADDR> <channel>
> 
> When <channel> does not equal 1 both computers connect no with no
> problem. When <channel> equals 1 I receive the error "Can't connect
> RFCOMM socket: Connection refused"
> 
> I tried this in to two different environments. 1) in a X-session and
> 2) in command line
> 
> 1) in GUI on the listing computer a dialogue box pops up requesting
> a pin for pairing. When I click cancel on the dialogue box of the
> listening machine the error "Can't connect RFCOMM socket: Connection
> refused" appears on the command line of the connecting machine.
> 
> 2) in command line mode on the listening computer nothing appears
> and I immediately receive the error "Can't connect RFCOMM socket:
> Connection refused" on in the command line of the connecting machine
> 
> These problems do not arise when attempting to connect on any other
> channels.
> 
> I have searched Google, looked at multiple forum posts on rfcomm
> connections, looked at forum posts on peoples' problems with rfcomm
> connections, reviewed this mailing list's archives, and I cannot
> find my specific problem.
> 
> Thank you for any advice you can provide or resources to which you
> can point me.
> 
> Regards,
> Isaiah
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
