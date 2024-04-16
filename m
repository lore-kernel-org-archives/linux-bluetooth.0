Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BE1311B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282029; cv=none; b=C2UQBloC3FMEAZ01JJcFXy/REAahz0GCWShiiBHPvZkGt/04jYWZBvCLNyNSZ2GrVo/7+ytv0Em3rtELKD3D1RXDysymIzxACi1ixiVIWAouQpwyz640lhznr5Q5XWDf7WEutNfE2HEj492kfy5FNGhOpNoPaKOiAlUh5hMBEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282029; c=relaxed/simple;
	bh=CDvUf501ExbeoTTLPR+fG8fyWMtt7DKGsn5hvuVK+ZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WCXa2gqcKXoqXGLfzp5f2JneY0Rxn6pk9UFqDg5WzX0NMHuRKCUATw573C/Rul5VdR4r3Bwv4iCrlfWAs3NM0OkusEta1dKin3DXHyr/56FJqR7o2NEDuwGCJ1sMRhVEd8ZC/uuZj+d8RHaBYcPPDbgEL+StUvb5Gue3xReTuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miblyTj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miblyTj0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0075AC32783;
	Tue, 16 Apr 2024 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282029;
	bh=CDvUf501ExbeoTTLPR+fG8fyWMtt7DKGsn5hvuVK+ZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=miblyTj00k3vc8E2sedPLfP1H8Vv7QO1krHptqzVWXTaTPlBc/KuVUlnbMP30Z9K6
	 lrz+IZfIhrASCk86pKccRRgRIaeIzKXJ9A8KXIyPROLZ69Mn6pbFFkASaEW3YAU4ho
	 FjU/K0AO3Q9xCrq7U9RVenp935qU/N2ESWGtyxLbRjUqULA2EZ7Q0Zh4+RTOGbdLYi
	 AVs0gwXuuIuw2+/vjX9mFhV9schtA1wx51hZjcA/VAbJPDiGrZPwn2Xdw5lbGM+MVF
	 4Fr9TZKITXgDidNiQxJ6Qas0WNk3/2NTY8kw9lF8lLTgPF1XZFHxCE9TErShN62DMt
	 OhXXDvN+CniwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E935BD4F15F;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/bap: clean up requests for a stream before
 freeing it
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171328202895.2661.5369436299401809718.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:40:28 +0000
References: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
In-Reply-To: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Apr 2024 22:55:55 +0300 you wrote:
> Cancel stream's queued requests before freeing the stream.
> 
> As the callbacks may do some cleanup on error, be sure to call them
> before removing the requests.
> 
> Fixes:
> =======================================================================
> ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000013430
> READ of size 8 at 0x60d000013430 thread T0
>     #0 0x89cb9f in stream_stop_complete src/shared/bap.c:1211
>     #1 0x89c997 in bap_req_complete src/shared/bap.c:1192
>     #2 0x8a105f in bap_process_queue src/shared/bap.c:1474
>     #3 0x93c93f in timeout_callback src/shared/timeout-glib.c:25
> ...
> freed by thread T0 here:
>     #1 0x89b744 in bap_stream_free src/shared/bap.c:1105
>     #2 0x89bac8 in bap_stream_detach src/shared/bap.c:1122
>     #3 0x89dbfc in bap_stream_state_changed src/shared/bap.c:1261
>     #4 0x8a2169 in bap_ucast_set_state src/shared/bap.c:1554
>     #5 0x89e0d5 in stream_set_state src/shared/bap.c:1291
>     #6 0x8a78b6 in bap_ucast_release src/shared/bap.c:1927
>     #7 0x8d45bb in bt_bap_stream_release src/shared/bap.c:5516
>     #8 0x8ba63f in remove_streams src/shared/bap.c:3538
>     #9 0x7f23d0 in queue_foreach src/shared/queue.c:207
>     #10 0x8bb875 in bt_bap_remove_pac src/shared/bap.c:3593
>     #11 0x47416c in media_endpoint_destroy profiles/audio/media.c:185
> =======================================================================
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/bap: clean up requests for a stream before freeing it
    (no matching commit)
  - [BlueZ,2/2] bap: cancel stream operation before freeing setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3a6a6459cbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


