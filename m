Return-Path: <cyrus@holtmann.org>
From: Alex Fiestas <afiestas@kde.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Specifying destination path in obexd/bluez-5
Date: Mon, 31 Dec 2012 09:56:50 +0100
Message-ID: <13320115.C4qltrvZED@monsterbad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Last time I tried to port KDE's obex support completely to obexd (we are 
already using obexd-client for opp sendfile) I couldn't complete it because 
there is no way of programatically specify the destination path of the 
incoming files, iirc using either ftp or opp.

Now checking out BlueZ-5 I'm not sure I see a way of doing it either.

So, is there anyway of changing the destination path programatically without 
having to restart obexd-server? If not, can I add a wish somewhere (bugrack?) 
for it? Would you consider?

Thanks and congratulations for BlueZ-5 :)!
