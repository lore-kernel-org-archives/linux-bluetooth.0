Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2009 10:03:48 +0100
Message-ID: <a0d5085b0909300203u2aa7eafao9aa8d140d164e236@mail.gmail.com>
Subject: plugins for bluetoothd
From: Luiz Pena <carlos.luiz.pena@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want to start writing a plugin for bluetoothd, but am getting stuck
on some problems. What defines when a plugin is loaded? Is it possible
to load a plugin without actually having to connect the piece of
hardware?
I thought it was possible to do it with /var/run/sdp but it seems not.

I have also been looking for a reference of what exactly can be done
over /var/run/sdp but haven’t found anything.

I know these are probably well known questions, but I would appreciate
being pointed in the right direction since I haven’t found anything.
Thanks,
Carlos
