Return-Path: <cyrus@holtmann.org>
Message-ID: <483FD030.5080404@powercraft.nl>
Date: Fri, 30 May 2008 12:00:16 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <FE07A25A-8396-4E23-9633-B5D03B3BF896@gmail.com>
In-Reply-To: <FE07A25A-8396-4E23-9633-B5D03B3BF896@gmail.com>
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

Johan Hedberg wrote:
> Hi,
> 
> As you may know recent BlueZ versions (since 3.30) and the upcoming  
> 4.x branch will use plugins for several different purposes, including  
> local bluetooth services (e.g. audio, input, network, etc) which were  
> previously implemented as separate processes. For the separate process  
> case we had an API for starting and stopping services but currently  
> there is no D-Bus methods planned to allow loading or unloading of  
> plugins at runtime. Instead, there only is a configuration file (/etc/ 
> bluetooth/main.conf added in 3.32) which can be used to specify which  
> plugins should not be loaded when hcid starts.
> 
> We were today debating with the developers whether it would be useful  
> to have a D-Bus API for dynamically loading and unloading of installed  
> plugins but couldn't really reach a consensus. Personally I have a  
> "gut" feeling that these would be good to have but don't really have a  
> really good use case for it. Marcel otoh doesn't feel a need for it  
> and won't add the API without good use cases. So, we would like to  
> hear any needs (with use cases) that people on this list might have  
> for this feature.
> 
> Johan

 From a general point of view, I would say the following:

Dynamically loading functionality is an very good thing! This means no 
resources are lost during startup and only features are only loaded when 
needed.

If we uses bluez in a mobile device, resources take up power and speed. 
Having a dynamic feature that loads "input" and "audio" plugins when 
such devices really are connected would be a great. No need for users to 
manually enable disable features.

Both from usability and technical point of view i would suggest 
dynamically loading and unloading plugins.

Thanks in advance,

Jelle


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
