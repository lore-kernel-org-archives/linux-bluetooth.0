Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Error while setting RFCOMM security options
From: Stephen Crane <steve.crane@rococosoft.com>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: BlueZ-devel List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084285384.893.17.camel@fischer>
References: <1084285384.893.17.camel@fischer>
Content-Type: text/plain
Message-Id: <1084286129.3363.84.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 May 2004 15:35:30 +0100

BlueZ doesn't support these socket options for RFComm yet.

On Tue, 2004-05-11 at 15:27, Julien Campana wrote:
> Hi!
> 
> I'm trying to connect to a device over RFCOMM using the flags
> "authenticate", "encryption" and "master". Part of the code is: 
> 
> /******************************************/
> if ((fd = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
>      return fd;
> 
> memset(&local_addr, 0, sizeof(local_addr));
> local_addr.rc_family = AF_BLUETOOTH;
> bacpy(&local_addr.rc_bdaddr, BDADDR_ANY);
> if ((err = bind(fd, (struct sockaddr *)&local_addr, sizeof(local_addr)))
> < 0) {
>      close(fd);
>      return err;
>    }
> 
> int opt = 0;
> if (master) opt |= L2CAP_LM_MASTER;
> if (auth) opt |= L2CAP_LM_AUTH;
> if (encrypt) opt |= L2CAP_LM_ENCRYPT;
> 
> 
> 
> if (setsockopt(fd, SOL_RFCOMM, L2CAP_LM, &opt, sizeof(opt)) < 0) {
>      printf("WARNING can't set link Mode (reason: %s)\n\n",
> strerror(errno));
>    }
> /*******************************************/
> 
> This programm outputs the following message: 
> WARNING can't set link Mode (reason: Protocol not available)
> 
> Why? The L2CAP protocol is available as well as the RFCOMM protocol on
> my machine (l2ping actually works and my program exchanges data over
> RFCOMM without any problem).
> 
> Am I wrong in the way of setting these security flags?
> 
> Thank you for your answers.
> 
> Julien Campana
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
