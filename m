Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Setting up two connections at the same time
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <439E98E4.4010800@service2media.com>
References: <439E98E4.4010800@service2media.com>
Content-Type: text/plain
Message-Id: <1134471824.29210.20.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 13 Dec 2005 12:03:44 +0100

Hi Herman,

> I am trying to develop an application which performs an inquiry and will 
> then perform a service search on the found devices using multiple 
> threads. This fails however because these threads all try to setup a 
> connection at the same time which is not possible off course. I have 
> traced the problem down to the HCI layer which sends a Command Status 
> event for the first Create Connection request indicating that it has 
> started the connection setup. But the Command Status event indicates to 
> the host that it is ready to receive the next HCI command. However the 
> next command in the queue is the second Create Connection request which 
> is then sent to the HCI controller. The controller off course rejects 
> this request with a status 0x0C (Command Disallowed). This error is 
> propagated to the higher layers (l2cap and sdp) and eventually the 
> sdp_connect fails with errno set to EBADFD.
> What is the best way to handle this situation? The EBADFD doesn't really 
> indicate that the application can retry the request. Wouldn't it be 
> better to handle this at the host HCI layer? That is the only entity 
> which can possibly keep track of the HCI controller state and perform 
> the next connection request only when the Connection Complete event from 
> the previous request has been received. This way the requests could be 
> serialized. Or is this way too complex?

the same question came already came up some time ago. I don't know of
any Bluetooth chip that allows to establish multiple baseband links at
the same time. I personally think that such a chip will never be build,
because it is way to expensive. Once you received the Connection
Complete event you can ask the chip to establish another link to another
device. Or you simply use multiple dongles for this task.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
