Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 2 Nov 2007 14:28:04 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D000880396F519@esebe104.NOE.Nokia.com>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>	<471E2829.5020303@free.fr>	<719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>	<4729E570.6060202@free.fr><719D5CCC2F6E3644B0A9F5C9B1D00088039392F0@esebe104.NOE.Nokia.com>
	<472A0CDB.50104@free.fr>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Kai's experimental ALSA/A2DP plugin patch review
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

Hi,

quick reply to myself:

On 02 November 2007, Vehmanen Kai wrote:
>Hmm, but for instance gsta2dpsink works with the iMuff 
>headset, while the system-timer paced pcm_bluetooth.c doesn't.

oops, I mixed the headset models, it was something else
than iMuff. Anyways, it seems that some headsets take advantage
of L2CAP flow control (-> blocking writes to L2CAP will work 
more reliably as we don't need to guesstimate hw_ptr), while 
some don't (-> we have to use a system timer). Now my patch tries 
to work with both (it uses a system timer, but can adjust the hw_ptr 
if needed as well), but as Fabien pointed out, some cases are still 
not handled. Now I guess a good follow-up question is that should
the plugin try to verify whether L2CAP flow-control is used
or not, and then adjust its behaviour...?

-- 
first.surname@nokia.com (Kai Vehmanen)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
