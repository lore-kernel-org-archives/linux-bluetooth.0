Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100708201556k4c472fcbxa96df9191b63aae1@mail.gmail.com>
Date: Mon, 20 Aug 2007 19:56:11 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C9E453.7020604@free.fr>
MIME-Version: 1.0
References: <46C875BA.90204@free.fr>
	<2d5a2c100708191902k599014cbo1e08c9c7a3febd45@mail.gmail.com>
	<46C9D2E0.5050404@free.fr>
	<2d5a2c100708201111s5d73b6b6qdbef9c399cb3b3a7@mail.gmail.com>
	<46C9E453.7020604@free.fr>
Subject: Re: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
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

Hi again,

On 8/20/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> I think these issues you have (too fast, too slow) is because the poll()
> support in your version of pcm_bluetooth is broken.
> I suggest you have a look at the pulse and jack plugin (available in
> lastest alsa-plugins), and also to my patch to see how it fits in the
> picture.

Yep, it seems you are right on this. My solution even  consume more
cpu and solves nothing, too bad I couldn't figure out this before.

> A correct implementation of poll is the only way you will be able to
> wake up the application only when you are ready to accept more data.
> This means you must never block in the  bluetooth_a2dp_write functions,
> either explicitely (through pthread_mutex_lock for instance :-) ) or
> implicitely (using a blocking send call on a socket for instance).
> The blocking is done by libasound itself, by polling on the fd's you
> give to it.

Not sure how we could avoid blocking on transfer callback, that was
my idea but as I need to protect the buffer from being concurrent
accessed I end up with almost the same solution we already had.
Apart from that it seems you already solve the rate problem by properly
handle hw_ptr on a thread, adding the rate constrait spec mention
whould probably only add cpu consumption.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
