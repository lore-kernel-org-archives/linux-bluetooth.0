Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Linking to BlueZ from non-GPL code
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA9387077868B0@scsmsx401.amr.corp.intel.com>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA9387077868B0@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1117671595.31350.54.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 02 Jun 2005 02:19:55 +0200

Hi Trevor,

> Ok, then it sounds like we (me and the lawyers and you) are all in
> agreement -- what it comes down to is the source of the *.h files.  If
> they come from the kernel (which wouldn't make sense for BlueZ), then
> things would be ok.  However, trying to use BlueZ user-level *.h files
> with not-GPL would not be allowed.  (I'm just reiterating this for the
> benefit of clarity and consensus).

for the kernel header files this is not clear to me, because Linus only
stated the exception for system calls and not any actual code. I have
seen people argumenting into both directions and since the BlueZ kernel
include files are no use for userspace programs, I won't take any of the
positions.

For the *.h files from bluez-libs the GPL is the current state and thus
any program using them will be GPL.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
