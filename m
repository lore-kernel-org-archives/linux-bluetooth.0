Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200708270945.07388.denis.kenzior@trolltech.com>
References: <7AC80B65-3C6D-43DB-8CED-600F9A604255@cadvium.net>
	<1187957366.15402.141.camel@violet>
	<200708270945.07388.denis.kenzior@trolltech.com>
Date: Mon, 27 Aug 2007 14:54:23 +0200
Message-Id: <1188219263.15402.304.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Avetana GPL Stack
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

Hi Denis,

> Speaking of JSR82.  I've been hearing our PSO department has been working with 
> Sun to get a working JSR82 stack on top of Linux.  They've been having some 
> problems supporting some JSR82 defined methods, for instance:
> 
> /**
>  * Checks if a remote device was authenticated.
>  *
>  * @param addr Bluetooth address of a remote device
>  * @param pBool pointer to variable where the result is to be stored:
>  *              <code>JAVACALL_TRUE</code> if authenticated,
>  *              <code>JAVACALL_FALSE</code> otherwise
>  * @retval <code>JAVACALL_OK</code> on success
>  * @retval <code>JAVACALL_FAIL</code> on failure
>  */
> javacall_result javacall_bt_bcc_is_authenticated(
>         const javacall_bt_address addr,
>         /*OUT*/javacall_bool *pBool);
> 
> The best way to determine this is of course for a specific transport 
> connection, e.g. getsockopt RFCOMM_LM & L2CAP_LM.  However, short of using 
> the 'hcitool con' implementation, I'm not sure how to get this information.  
> Should this be up for inclusion into the org.bluez.Adapter API?  What's the 
> best way to do this?  I can probably work on a patch if required...

there is actually no point in checking if a connection is authenticated
or not. If you require an authenticated connection, then this would not
have been established in the first place.

Anyhow with the Simple Pairing extensions I will introduce a
SOL_BLUETOOTH that is valid for all sockets and lets your retrieve this
information without checking all local adapters.

However there is an issue with the implementation side of this. You can
not always know if you are authenticated. You don't get an information
that the authentication was successful in case you are the passive side.
You only reply to the link key request. Once you see an encryption
changed event you can assume that you are authenticated, but in general
you can use authentication and not encryption. Not that this makes sense
and is in general insecure, but it is possible.

> /**
>  * Increases or decreases encryption request counter for a remote device.
>  *
>  * @param addr the Bluetooth address of the remote device
>  * @param enable indicated whether the encryption needs to be enabled
>  * @param pBool pointer to variable where the result is to be stored:
>  *              <code>JAVACALL_TRUE</code> if the encryption must be
> changed,
>  *              <code>JAVACALL_FALSE</code> otherwise
>  * @retval <code>JAVACALL_OK</code> on success
>  * @retval <code>JAVACALL_FAIL</code> on failure
>  */
> javacall_result javacall_bt_bcc_set_encryption(
>         const javacall_bt_address addr,
>         javacall_bool enable,
>         javacall_bool *pBool);
> 
> Same problem with this one.  Ideally the setsockopt RFCOMM_LM and L2CAP_LM 
> should work on client sockets as well (I think they only work on server 
> sockets right now).  Any ideas on how to implement this one?

For Simple Pairing this has to be done anyway, but we can have this for
client connections with our current kernel, too. However the real need
for this is not really there. It is actually stupid to enforce
encryption from the client side if you are not using Simple Pairing.

I am not a big fan of JSR-82. Personally I think the specification
authors were total morons that had no clue how Bluetooth actually work.
However I would support getting this working, but not at all costs.
Changes that only benefits JSR-82 need to be reasonable and make sense.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
