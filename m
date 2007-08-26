Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 27 Aug 2007 09:45:07 +1000
References: <7AC80B65-3C6D-43DB-8CED-600F9A604255@cadvium.net>
	<1187957366.15402.141.camel@violet>
In-Reply-To: <1187957366.15402.141.camel@violet>
MIME-Version: 1.0
Message-Id: <200708270945.07388.denis.kenzior@trolltech.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel,

Speaking of JSR82.  I've been hearing our PSO department has been working w=
ith =

Sun to get a working JSR82 stack on top of Linux.  They've been having some =

problems supporting some JSR82 defined methods, for instance:

/**
 * Checks if a remote device was authenticated.
 *
 * @param addr Bluetooth address of a remote device
=A0* @param pBool pointer to variable where the result is to be stored:
=A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0<code>JAVACALL_TRUE</code> if authenticated,
=A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0<code>JAVACALL_FALSE</code> otherwise
=A0* @retval <code>JAVACALL_OK</code> on success
=A0* @retval <code>JAVACALL_FAIL</code> on failure
=A0*/
javacall_result javacall_bt_bcc_is_authenticated(
=A0 =A0 =A0 =A0 const javacall_bt_address addr,
=A0 =A0 =A0 =A0 /*OUT*/javacall_bool *pBool);

The best way to determine this is of course for a specific transport =

connection, e.g. getsockopt RFCOMM_LM & L2CAP_LM.  However, short of using =

the 'hcitool con' implementation, I'm not sure how to get this information.=
  =

Should this be up for inclusion into the org.bluez.Adapter API?  What's the =

best way to do this?  I can probably work on a patch if required...

/**
=A0* Increases or decreases encryption request counter for a remote device.
=A0*
=A0* @param addr the Bluetooth address of the remote device
=A0* @param enable indicated whether the encryption needs to be enabled
=A0* @param pBool pointer to variable where the result is to be stored:
=A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0<code>JAVACALL_TRUE</code> if the encryptio=
n must be
changed,
=A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0<code>JAVACALL_FALSE</code> otherwise
=A0* @retval <code>JAVACALL_OK</code> on success
=A0* @retval <code>JAVACALL_FAIL</code> on failure
=A0*/
javacall_result javacall_bt_bcc_set_encryption(
=A0 =A0 =A0 =A0 const javacall_bt_address addr,
=A0 =A0 =A0 =A0 javacall_bool enable,
=A0 =A0 =A0 =A0 javacall_bool *pBool);

Same problem with this one.  Ideally the setsockopt RFCOMM_LM and L2CAP_LM =

should work on client sockets as well (I think they only work on server =

sockets right now).  Any ideas on how to implement this one?

-Denis

On Friday 24 August 2007 22:09, Marcel Holtmann wrote:
> Hi Robert,
>
> > I made some patches to the Avetana GPL Stack (the version that works
> > with Bluez which is why I am posting here).  If any one is interested
> > in JSR82, java bluetooth stuff, shoot me an email.
>
> I would prefer if someone takes over the maintainership and creates a
> working JSR82 stack that can use the latest BlueZ versions. Personally I
> am not using Java at all so I might be of no help here.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
