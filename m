Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Stephen Crane <steve.crane@rococosoft.com>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <000201c31508$200eac20$6400a8c0@baked>
References: <000201c31508$200eac20$6400a8c0@baked>
Content-Type: text/plain
Message-Id: <1052757449.1664.85.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 12 May 2003 17:37:29 +0100

Hi Daryl,

On Thu, 2003-05-08 at 03:18, Daryl Van Vorst wrote:
> Steve,
> 
> > >         2.) There appears to be a problem handling continuation 
> > > states. Handling continuation state is optional. We found 
> > that if the 
> > > querying device sends a maximum byte count of 100, the 
> > continutation 
> > > state worked fine. But if the querying device sent a maximum byte 
> > > count of 8, the continuation state doesn't work (the 
> > continuation flag 
> > > wasn't recognized in the next packet). I can dig up an 
> > example log if 
> > > it would help.
> > 
> > Yeah it would be good to get a log. I imagine 8-bytes is 
> > pretty close to the minimum size.

Would it be possible to get an hcidump from the machine on which the SDP
server is running? (I am interested to see what data the SDP server is
actually returning.)

(hcidump -x -w file.dump -i hci0)

Thanks,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
