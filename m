Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 22:15:57 -0300
Message-ID: <2d5a2c100910141815l3300ee34p12fbbac2dd6a96b6@mail.gmail.com>
Subject: dun profile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi List,

Im trying to put an end to this problem of detecting rfcomm port
properly, so what seems to be missing is to associate the profile to
the port so that udev can properly announce it as modem in case of dun
profile. I don't know of any mechanism to attach any profile
information to the port itself, but in theory we could identify the
port by name, so instead of using rfcomm# for all ports created by
Serial interface we could name it dun# for instance, so how about
that? Also we probably want to make this persistent so once this is
configured this will be restored in the next boot.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
