Return-Path: <steve.crane@rococosoft.com>
Subject: New BlueZ Security Manager
From: Stephen Crane <steve.crane@rococosoft.com>
To: marcel@rvs.uni-bielefeld.de, maxk@qualcomm.com
Cc: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1046871982.2860.1155.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 05 Mar 2003 13:46:23 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel, Max,
On Marcel's German slides (for which I've lost the link) I noticed a
revamped security manager on the TODO list. However I don't ever
remember seeing a discussion about it here on the list. I'd like to
kick-start this discussion if possible.

The main thing wrong with hcid (in my opinion) is what the security
white-paper (http://www.bluetooth.com/upload/24Security_Paper.PDF)
defines as support for security mode 2. This is where the
owning-application enforces the security requirements for a service.

The difference between this and the current setup (security modes 1 and
3 in the whitepaper's terminology) is (I think) that hcid enforces
permissions at the ACL level whereas service-level security takes place
/after/ the ACL link is already up. It should be possible to allow SDP
searches for example, but deny access to services discovered through
SDP.

I don't think that the current kernel API is rich enough to permit this.
It ought to be possible for a server listening on a socket to discover
the BDADDR of the connecting peer and either accept() or reject access
--- probably through an ioctl(). On the client-side, a special error
return from (or argument to) connect() could indicate that a PIN was
required to connect.

Thoughts?
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
