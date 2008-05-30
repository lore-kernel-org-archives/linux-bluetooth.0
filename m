Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 May 2008 09:34:51 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FE07A25A-8396-4E23-9633-B5D03B3BF896@gmail.com>
Message-ID: <Pine.LNX.4.64.0805300855120.10076@simba.math.ucla.edu>
References: <FE07A25A-8396-4E23-9633-B5D03B3BF896@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Use cases for dynamically loading/unloading
	plugins?
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

On Fri, 30 May 2008, Johan Hedberg wrote:

> We were today debating with the developers whether it would be useful  
> to have a D-Bus API for dynamically loading and unloading of installed  
> plugins ... So, we would like to  
> hear any needs (with use cases) that people on this list might have  
> for this feature.

I'm using my Nokia 770 with 64 Mb RAM and no swap file.  Having finished 
listening to classic Lawrence Welk MP3's :-) I want to run the web browser, 
which is a memory hog.  A2DP service, go away!  

Incoming voice chat: I want to listen/talk to it now, not after a massive 
0.5 Mb of shared libraries are mapped.  I would want HSP/HFP ready to go, 
starting from boot, if I were into voice chat.  But with the option to shut 
it down if I have a resource problem. 

I do the pairing procedure on a new Bluetooth keyboard or mouse.  
Presumably I now want to actually type something.  hcid would automatically 
load the plugin for HID, right?  

Returning to the voice chat case, it's tempting to add to the chat software 
(ekiga?  gizmo?  skype?) a feature to send the "prepare HSP" message when 
it starts up, but I think that's commingling protocol layers.  I'm not 
really expert in audio multiplexing, but I believe the PulseAudio people 
are talking about creating their own plugin for a Bluetooth sink or source, 
that knows the Bluez API and could potentially send such a message.  Or 
maybe the better place is in ALSA, when the Bluetooth audio sink/source is 
actually opened.  Or even better (or worse?), it should be possible to 
begin to open the source/sink with nothing connected to it, and the Bluez 
side will take care of loading the plugin and *finding* a headset to 
connect to the source/sink.  (If there were none, the open would eventually 
fail.)

On the API details, I think it's a really bad idea to entitle the method 
call "load plugin" or "get rid of plugin", because it commits the 
implementer to actually having plugins that can be loaded -- as well as 
committing in advance to the names of the plugins.  I would prefer to 
advertise the method as "prepare for quick action on [protocol]", or "done 
with [protocol] for now".  The names of the protocols are defined in the 
Bluetooth spec, and presumably software developers can rely on them to not 
change.

I'm thinking about automatically unloading plugins after a period of 
non-use.  I wonder if the timeout should be a parameter to the "prepare 
protocol" method, or should be in a static configuration file, or both.

Here's another use case: one of the plugins has a bug.  Often (but far from 
always) you can work around bugs by unloading the plugin and reloading it.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
