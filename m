Return-Path: <rthiaga1@urbana.css.mot.com>
Message-ID: <412CB7E9.30408@urbana.css.mot.com>
Date: Wed, 25 Aug 2004 11:01:45 -0500
From: Radha Thiagarajan <rthiaga1@urbana.css.mot.com>
MIME-Version: 1.0
To: marcel@holtmann.org, bluez-devel@lists.sourceforge.net
CC: William List <WLIST@motorola.com>,
   Radha Thiagarajan <rthiaga1@urbana.css.mot.com>
Subject: TIOCMIWAIT & TIOCGICOUNT
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

I am interested in implementing the two ioctls TIOCMIWAIT and TIOCGICOUNT 
for RFCOMM that mimic the serial driver behavior. Do you have any 
recommendations on how this could be done? My initial thought would be to 
put a process that calls TIOCMIWAIT to sleep and then wake it up when a 
MSC packet is received. The user could then call TIOCGICOUNT to 
retrieve which control lines have changed. Any suggestions on this topic 
would be greatly appreciated.
