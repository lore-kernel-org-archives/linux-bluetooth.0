Return-Path: <steve.crane@rococosoft.com>
Subject: specifying client-side link mode properties before connect()
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
Cc: marcel@holtmann.org
Content-Type: text/plain
Message-Id: <1080744176.1907.15.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 15:42:56 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,
[I think I may have asked something along these lines before, but I
can't remember what the outcome was...]

I have a server application which can specify the link mode requirements
of incoming connections using setsockopt(sock, SOL_L2CAP, L2CAP_LM, opt,
sizeof(opt)). This works fine, if a client can't meet the requirements,
no connection is made and the server's accept() sees nothing.

However I'd now like to be able to specify these requirements to the
connect() call on the client-side. That is, I'd like to call setsockopt
specifying the client's requirements (master, auth, encrypt) before
calling connect(). While I can /do/ this, the LM parameters seem to have
no effect. For example, I can set the L2CAP_LM_MASTER flag on both
sides, yet a connection is still established.

I suppose my question really is: are there any plans to implement this? 
Or is the usual answer (to send a patch) the correct one :-)?

Thanks,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
