Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Shneider <shneiderkyle@gmail.com>
Date: Tue, 16 Aug 2016 23:09:49 +0300
Message-ID: <CAMib2Ga66EkT7QWSZi_ew+ESQ_O97koY3OZgCy8mOiUnXes0wg@mail.gmail.com>
Subject: MediaFolder interface
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.
I'm successfully setting connection between iOS a2dp source and linux
a2dp sink and...
1) When I'm trying to use Search method of MediaFolder1 interface
passing different arguments it always returns NotSupported error
(ListItems and ChangeFolder methods works fine). In the bluez docs it
is written that property 'Searchable' of player object (it is False on
default) can be enabled using MediaFolder interface. So how can I
change this property to True?
2) What is the acceptable format of 'dict filter' argument of
ListItems method (and Search)? I've tried different variants but it's
always InvalidArguments error.
- {'Start':0, 'End':0, 'Attributes':['track', 'album']}
- dbus.Dictionary({'Start':0, 'End':0, 'Attributes':['track',
'album']}, signature:'sv')
- etc
When I pass an empty dictionary to this method everything ok.

-- 
Kyle Shneider
