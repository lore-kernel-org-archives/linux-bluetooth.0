Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710242155y7020adc3sc00e4873fa39911b@mail.gmail.com>
Date: Wed, 24 Oct 2007 22:55:30 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6BA4FAD4-57D8-419A-B6BB-A86591FFDD3F@canonical.com>
MIME-Version: 1.0
References: <6BA4FAD4-57D8-419A-B6BB-A86591FFDD3F@canonical.com>
Subject: Re: [Bluez-devel] GUI for Bluetooth headsets..
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

Michael

It would be more fitting to have the gui talk to the audio service
with dbus to set up headsets. The stuff in asoundrc is a convenience
for doing it manually.

The wiki has examples of the python code that is needed here. We could
mock something up in python as a proof of concept. I suspect that
ultimately audio service ui would be glued into the bluetooth applet.

Brad

On 10/23/07, Michael Frey <michael.frey@canonical.com> wrote:
> Is there any plan for creating a UI for discovering and pairing a
> bluetooth headset?
>
> Something that adds the pcm entry in the asoundrc file.
>
> Thanks,
> Michael
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
