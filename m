Return-Path: <cyrus@holtmann.org>
Message-ID: <098701c8def5$0eebd730$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <066701c8de28$51a90a70$6701a8c0@freqonedev>
	<1215277418.4349.1.camel@californication>
Date: Sat, 5 Jul 2008 18:15:44 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Adapter.RegisterAgent
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi, Marcel.

> Hi David,
>
>> There may be a valid use-case to allow for the Agent to be a separate
>> process.  However, there needs to be a way to designate the BusName 
>> of
>> the connection from the other Agent process to the System bus.
>
> I really have no idea what you are talking about. The agent can always
> be a separate process. The agent for CreatePairedDevice must be the 
> same
> process as the caller. That is on purpose.

Actually, in RegisterAgent, the agent cannot (now) be a separate 
process, because the path name provided is a DBus Object Path only. What 
is used is the unique connection name of the process calling 
RegisterAgent.  Line 4143 of adapter.c:

    name = dbus_message_get_sender(msg);

One other point: if the Object Path is not found, no error is thrown. 
The syslog indicates that the agent was registered, although it will 
never work.

WRT CreatePairedAgent in the same process, fine enough.  I can 
understand the rationale.  Got it.

Best...
>
> Regards
>
> Marcel
>
>
>
>
> 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
