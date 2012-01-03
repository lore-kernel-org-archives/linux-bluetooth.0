Return-Path: <cyrus@holtmann.org>
From: mindentropy <mindentropy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Problem with bluez-simple-agent call in .bashrc or .bash_profile.
Date: Wed, 04 Jan 2012 00:08:01 +0530
Message-ID: <2300688.s88ILHziNR@terranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
  I am trying to automate bluetooth pairing at startup and I have put bluez-
simple-agent hci0 bdaddr in my bashrc and it always fails. When I run it 
manually it works i.e. I can pair. Why is that? 
It fails with "Connection error: In progress". I am not sure what it means. To  
replicate simply write "sudo bluez-simple-agent hci0 <bdaddr>".

Thanks.
