Return-Path: <cyrus@holtmann.org>
Message-ID: <4A2D0142.8070100@redhat.com>
Date: Mon, 08 Jun 2009 14:17:06 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stefan Seyfried <seife@suse.de>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
References: <4A27DFBE.407@redhat.com> <20090605145144.GB7296@suse.de> <4A2CF696.8020702@redhat.com> <4A2CFD04.7020606@suse.de>
In-Reply-To: <4A2CFD04.7020606@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/08/2009 01:59 PM, Stefan Seyfried wrote:
> Petr Lautrbach wrote:
>
>> but there is running boot (changing runlevel) process, so sometime after starting dbus is started
>> bluetooth again, this time successfully
>
> Triggered by what? A init script that is always enabled? Is it checking if
> there is an adapter present? If not, it's unconditionally always starting
> bluetoothd (and thus the ondemand functionality is not strictly needed ;)
>

triggered by this code:

+has_bt_devices()
+{
+	#Look for Bluetooth adapters:
+	udevadm info --export-db | grep -q -e '/devices/.*/bluetooth/.*'
+
+	return $?
+}
+
  case "$1" in
    start)
  	echo -n "Starting $DESC:"
  	if $DAEMON_ENABLE && [ -x "$DAEMON_EXEC" ]; then
-		$DAEMON_EXEC
-		echo -n " $DAEMON_NAME"
+		if [ -z $DAEMON_ONDEMAND ] || has_bt_devices; then
+			$DAEMON_EXEC
+			echo -n " $DAEMON_NAME"
+		fi


It starts if $DAEMON_ONDEMAND is not set or if there are some bluetooth adapters.
In case that $DAEMON_ONDEMAND is set and has_bt_devices() has returned non-zero, it won't start.

Petr
-- 
Petr Lautrbach, Red Hat, Inc.
