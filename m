Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <462E21F0.4080204@vasmac.com>
Date: Tue, 24 Apr 2007 09:27:44 -0600
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>	<462E02FB.8000600@vasmac.com>
	<fc27e74b0704240808j3ca3df0cr5c415d39acf29ac4@mail.gmail.com>
In-Reply-To: <fc27e74b0704240808j3ca3df0cr5c415d39acf29ac4@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH]Dynamic Alternate Setting patch (hci_usb.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

list subscribe wrote:
> Jose,
>
>     Hi Alok,
>
>     This is a good start. There are a few other things to consider:
>
>     * Are there error conditions in hci_usb_tx_complete that need to
>     be handled?
>
>
> I am not sure what you mean.  Since we don't flush submitted  URBs, 
> these URBs are handled like normal ones. If their status indicates 
> error the error_tx count will be incremented. What error conditions 
> are u pointing at?
The outstanding urbs are dequeued and put on a temporary list and 
resubmitted
after changing the configuration. But there may be an active URB that is 
being
transmitted that will be reported with an error status. 
hci_usb_tx_complete will
release this urb so it can't be resubmitted. This may also result in a 
small glitch
when switching to an alternate.
>
>     * How do you make sure data for different channels is interleaved?
>
>
> Well , since we know that there can be max 3 SCO channels , we can 
> have 3 separate queues, and use a round robin method to send out the 
> packets from the queues. i am not sure about this idea though.  What 
> do u think?
I think this is the right approach; I found that it's very important to 
do the
interleaving properly. There is an issue if one of the queues is empty
(i.e. buffer underrun). What to do in that case? Send silence?

Jose


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
