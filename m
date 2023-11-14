Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479333CF0
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ru5XSyAA"
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23F912A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 10:38:02 -0800 (PST)
Received: from github.com (hubbernetes-node-ba91505.va3-iad.github.net [10.48.135.41])
	by smtp.github.com (Postfix) with ESMTPA id 16E1B8C0C31
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1699987082;
	bh=/jvI3kgi4amoRniFns5jWgEN8vHQhE+SvooUYW+qlUc=;
	h=Date:From:To:Subject:From;
	b=Ru5XSyAAlL3tONfCayjYnFRGTT2sTA/6l0ZCGczy40qBReAZ3/SkaoKnLzCjSCnqa
	 PC38SLNob2JLGvFjW9XrH8IbeV1pJvU2lUrj67E1/bXxXZj3Uf8uo5Lsb2ztUN/wwU
	 KKw7MNYdXk6Exz5xfVra9Tb9jk1k6tmSFJPs7CNU=
Date: Tue, 14 Nov 2023 10:38:02 -0800
From: Paul Otto <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7ef406-4b353a@github.com>
Subject: [bluez/bluez] 0d65d6: client: Add bluetoothctl-admin.1 man page
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 0d65d6862a050dd0bbdc1984bf549086ce9d75c4
      https://github.com/bluez/bluez/commit/0d65d6862a050dd0bbdc1984bf549086ce9d75c4
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-admin.rst

  Log Message:
  -----------
  client: Add bluetoothctl-admin.1 man page

This adds bluetoothctl-admin.rst which is then converted to
bluetoothctl-admin.1 using rst2man.


  Commit: 6c446bdd32a89afe2c5580f56940c31d826d9eb4
      https://github.com/bluez/bluez/commit/6c446bdd32a89afe2c5580f56940c31d826d9eb4
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-advertise.rst

  Log Message:
  -----------
  client: Add bluetoothctl-advertise.1 man page

This adds bluetoothctl-advertise.rst which is then converted to
bluetoothctl-advertise.1 using rst2man.


  Commit: face899cd83cbee9df42e72c8d6debea2c02bfaa
      https://github.com/bluez/bluez/commit/face899cd83cbee9df42e72c8d6debea2c02bfaa
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-endpoint.rst

  Log Message:
  -----------
  client: Add bluetoothctl-endpoint.1 man page

This adds bluetoothctl-endpoint.rst which is then converted to
bluetoothctl-endpoint.1 using rst2man.


  Commit: fa5fb919a97ee62d271eeec4fc93ce7a880f9239
      https://github.com/bluez/bluez/commit/fa5fb919a97ee62d271eeec4fc93ce7a880f9239
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-gatt.rst

  Log Message:
  -----------
  client: Add bluetoothctl-gatt.1 man page

This adds bluetoothctl-gatt.rst which is then converted to
bluetoothctl-gatt.1 using rst2man.


  Commit: 3797cedadb931d6e75a8636bab07163bcd122dd3
      https://github.com/bluez/bluez/commit/3797cedadb931d6e75a8636bab07163bcd122dd3
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-player.rst

  Log Message:
  -----------
  client: Add bluetoothctl-player.1 man page

This adds bluetoothctl-player.rst which is then converted to
bluetoothctl-player.1 using rst2man.


  Commit: c0678a4ddcc6befd697cbc6ae1c48036c63b9bca
      https://github.com/bluez/bluez/commit/c0678a4ddcc6befd697cbc6ae1c48036c63b9bca
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-scan.rst

  Log Message:
  -----------
  client: Add bluetoothctl-scan.1 man page

This adds bluetoothctl-scan.rst which is then converted to
bluetoothctl-scan.1 using rst2man.


  Commit: 4b353ae99ab66390561730974d0c4fecc4f38d6a
      https://github.com/bluez/bluez/commit/4b353ae99ab66390561730974d0c4fecc4f38d6a
  Author: Paul Otto <potto@ieee.org>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-transport.rst

  Log Message:
  -----------
  client: Add bluetoothctl-transport.1 man page

This adds bluetoothctl-transport.rst which is then converted to
bluetoothctl-transport.1 using rst2man.


Compare: https://github.com/bluez/bluez/compare/7ef40617a049...4b353ae99ab6
