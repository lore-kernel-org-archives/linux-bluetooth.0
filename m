Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Power level & Scan Timing
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael Vidal Aroca <rafael@3wt.com.br>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <4140924F.6080504@3wt.com.br>
References: <413F701F.5020905@3wt.com.br> <1094715184.5237.3.camel@notepaq>
	 <4140924F.6080504@3wt.com.br>
Content-Type: text/plain
Message-Id: <1094805339.5261.0.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 10 Sep 2004 10:35:39 +0200

Hi Rafael,

>     Now about the transmit/receive power, i know we can see what is 
> set....but the windows software allows us to controle low high or 
> medium...and as i understood from this mail this kind of configuration 
> can not be set with bluez.
>     Is it correct or is there a way to change the power level?

check the HCI part of the Bluetooth specification. If there is a command
for changing the power level, then it is possible otherwise it is not
possible using standard methods.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
